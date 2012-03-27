class Identity
  include MongoMapper::Document
  include OmniAuth::Identity::Models::MongoMapper

  key :email, String
  key :password_digest, String

  validates_uniqueness_of :email

  belongs_to :user
end