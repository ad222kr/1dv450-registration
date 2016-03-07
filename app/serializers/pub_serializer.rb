class PubSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :phone_number, :links
  has_one :position
  has_many :tags
  has_one :creator

  def links
    {
      self: api_pub_path(object.id),
      tags: api_pub_tags_path(object.id),
      creator: api_creator_path(object.id),
      # position: api_pub_position_path(object.id),
    }
  end


end
