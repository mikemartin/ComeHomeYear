class Identity
  include MongoMapper::EmbeddedDocument
  include OmniAuth::Identity::Models::MongoMapper

  key :email, String
  key :password_digest, String
  
  belongs_to :user
end