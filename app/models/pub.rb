class Pub < ActiveRecord::Base
  validates :name, presence: true
  validates :phone_number, presence: true
  validates :description, presence: true
end
