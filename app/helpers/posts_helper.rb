module PostsHelper
    def like_post?(user_id, likeable_id, likeable_type = "Post")
        Like.find_by(user_id: user_id, likeable_id: likeable_id, likeable_type: likeable_type)
    end
end
