require 'open-uri'

class User
  include MongoMapper::Document
  include Geocoder::Model::MongoMapper
  include Paperclip::Glue

  OCCUPATIONS = %w[
    Accountant
    Designer
    Programmer
    Lawyer
  ]

  key :provider, String
  key :uid, String
  key :email, String
  key :full_name, String
  key :occupation, String
  key :location, String
  key :coords, Array

  key :photo_file_name, String
  key :photo_file_size, Integer
  key :photo_content_type, String

  has_attached_file :photo, :styles => {
    :grid => '320x320#',
    :large => '1024x768>'
  }, :processors => [:cropper]

  timestamps!

  geocoded_by :location, :coordinates => :coords do |obj, results|
    if geo = results.first
      obj.coords = [geo.latitude, geo.longitude]
      obj.location = "#{geo.city}, #{geo.country}"
    end
  end

  after_validation :geocode
  after_update :reprocess_photo, :if => :cropping?

  ensure_index [[:coords, '2d']]
  
  validates_presence_of :provider
  validates_presence_of :uid
  validates_inclusion_of :occupation, :in => OCCUPATIONS, :allow_blank => true
  validates_uniqueness_of :uid, :scope => :provider

  validates_attachment :photo, :size => {:less_than => 2.megabyte},
    :content_type => {:content_type => ['image/jpeg', 'image/pjpeg', 'image/jpg', 'image/png', 'image/gif']}

  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  attr_accessible :provider, :uid, :full_name, :occupation, :location, :photo,
    :crop_x, :crop_y, :crop_w, :crop_h

  def cropping?
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end

  def photo_geometry(style=:original)
    return unless photo?
    @geometry ||= {}
    @geometry[style] ||= Paperclip::Geometry.from_file(photo.path(style))
  end

  def self.from_omniauth (auth)
    find_by_provider_and_uid(auth['provider'], auth['uid']) || create_with_omniauth(auth)
  end

  def self.create_with_omniauth (auth)
    User.new.tap do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      user.full_name = auth['info']['name']
      user.email = auth['info']['email']
      user.location = auth['info']['location']
      user.occupation = auth['info']['occupation']

      # this should go somewhere else
      if auth['provider'] == 'facebook'
        user.set_photo_from_url("http://graph.facebook.com/#{user.uid}/picture?type=large")
      end
      
      user.save
    end
  end

  def set_photo_from_url(url)
    temp = Tempfile.new(url.parameterize)
    temp.binmode
    temp.write(open(url).read)
    temp.flush
    self.photo = temp
  end

  private

  def reprocess_photo
    photo.reprocess!
  end
end