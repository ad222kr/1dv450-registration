class PositionSerializer < ActiveModel::Serializer
  attributes :id, :address, :longitude, :latitude, :links

  def links
    {
      self: api_position_path(object.id),
      pub: api_pub_path(object.pub.id)
    }
  end
end
