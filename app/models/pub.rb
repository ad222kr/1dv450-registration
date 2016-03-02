class Pub < ActiveRecord::Base
  include Rails.application.routes.url_helpers

  belongs_to :creator
  belongs_to :position
  has_and_belongs_to_many :tags

  validates :name, presence: true
  validates :phone_number, presence: true
  validates :description, presence: true

=begin
  def serializable_hash (options={})
    options = {
      only: [:name, :phone_number, :description]
      #include: [
      #  tags: { only: [:name] },
      #  position: { only: [:address, :longitude, :latitute] }
      #],
      # methods: :links
    }.update(options)
  end
=end



  def links
    {
      self: api_v1_pub_path(self)
    }
  end
end
