class Pub < ActiveRecord::Base
  belongs_to :creator
  belongs_to :position
  has_and_belongs_to_many :tags

  validates :name, presence: true
  validates :phone_number, presence: true, uniqueness: true
  validates :description, presence: true

  DEFAULT_DISTANCE = 5

  scope :starts_with, -> (name) { where("name like ?", "#{name}%")}
  scope :near_address, -> (address) { Position.near(address).pubs }
end
