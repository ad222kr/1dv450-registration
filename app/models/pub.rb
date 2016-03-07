class Pub < ActiveRecord::Base
  include Rails.application.routes.url_helpers

  belongs_to :creator
  belongs_to :position
  has_and_belongs_to_many :tags

  validates :name, presence: true
  validates :phone_number, presence: true
  validates :description, presence: true

end
