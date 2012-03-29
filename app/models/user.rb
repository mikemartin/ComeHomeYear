class User
  include MongoMapper::Document
  include Geocoder::Model::MongoMapper
  plugin Joint

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

  attachment :photo

  timestamps!

  geocoded_by :location, :coordinates => :coords do |obj, results|
    if geo = results.first
      obj.location = "#{geo.city}, #{geo.country}"
    end
  end

  after_validation :geocode

  ensure_index [[:coords, '2d']]
  validates_presence_of :provider
  validates_presence_of :uid
  validates_inclusion_of :occupation, :in => OCCUPATIONS
  validates_uniqueness_of :uid, :scope => :provider

  attr_accessible :provider, :uid, :full_name, :occupation, :location

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
      user.save
    end
  end
end