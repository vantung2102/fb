class CommentSerializer < ActiveModel::Serializer
    attributes :id, :content, :user, :post_id

    def user
        ActiveModelSerializers::SerializableResource.new(object.user,
                                                         each_serializer: UserSerializer, scope: { size: 40 })
    end
end
  