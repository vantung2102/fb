class PostSerializer < ActiveModel::Serializer
    attributes :id, :content, :image, :user, :comments, :likes
end
  