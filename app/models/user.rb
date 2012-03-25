class User
  include MongoMapper::Document
  plugin Joint

  OCCUPATIONS = %w[
    Accountant
    Designer
    Programmer
    Lawyer
  ]

  key :provider, String
  key :uid, String
  key :full_name, String
  key :occupation, String
  key :location, String
  key :coords, Array

  attachment :photo

  timestamps!

  ensure_index [[:coords, '2d']]

  attr_accessible :provider, :uid, :full_name, :occupation, :location

  def self.from_omniauth (auth)
    find_by_provider_and_uid(auth['provider'], auth['uid']) || create_with_omniauth(auth)
  end

  def self.create_with_omniauth (auth)
    User.new.tap do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      user.full_name = auth['info']['name']
      user.location = auth['info']['location']
      user.occupation = auth['info']['occupation']
      user.save
    end
  end
end