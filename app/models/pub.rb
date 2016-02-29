class Pub < ActiveRecord::Base
  belongs_to :creator
  validates :name, presence: true
  validates :phone_number, presence: true
  validates :description, presence: true
end
