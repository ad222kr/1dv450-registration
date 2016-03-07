class TagSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :name, :links

  def links
    {
      self: api_tag_path(object.id),
      pubs: api_pub_path(object.pub.id)
    }
  end
end
