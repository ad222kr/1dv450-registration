class Creator < ActiveRecord::Base
  # Class for end-users of the applications using this API
  has_many :pubs
  has_secure_password
end
