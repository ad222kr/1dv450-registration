class PositionSerializer < ActiveModel::Serializer
  attributes :id, :address, :longitude, :latitude
end
