class LikePostSerializer < ActiveModel::Serializer
    attributes :id, :user_id, :likeable_type, :likeable_id
end