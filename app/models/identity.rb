class Identity
  include MongoMapper::Document
  include OmniAuth::Identity::Models::MongoMapper

  key :email, String
  key :password_digest, String
  key :name, String
  key :location, String
  key :occupation, String

  validates_uniqueness_of :email
  validates_presence_of :name

  belongs_to :user
end