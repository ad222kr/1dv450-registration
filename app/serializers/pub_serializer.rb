class PubSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :phone_number
  has_one :position
  has_many :tags

  def links

  end


end
