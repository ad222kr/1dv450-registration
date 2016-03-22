class CreatorSerializer < ActiveModel::Serializer
  attributes :id, :email, :links

  def links
    {
      pubs: api_creator_pubs_path(object.id)
    }
  end
end
