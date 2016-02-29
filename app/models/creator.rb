class Creator < ActiveRecord::Base
  # Class for end-users of the applications using this API
  has_secure_password
end
