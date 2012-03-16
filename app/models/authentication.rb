class Authentication
  include MongoMapper::EmbeddedDocument

  key :provider, String
  key :uid, String
  
  belongs_to :user
end
