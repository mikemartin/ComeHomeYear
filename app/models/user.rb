class User
  include MongoMapper::Document
  plugin Joint
  
  one :identity
  one :authentication

  key :full_name, String
  key :occupation, String
  key :location, Array

  attachment :photo

  ensure_index [[:location, '2d']]
end