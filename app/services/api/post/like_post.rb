class Api::Post::LikePost < ApplicationService
    def initialize(user_id, likeable_type, likeable_id)
        @user_id = user_id
        @likeable_type = likeable_type
        @likeable_id = likeable_id
    end

    def call
        check = Like.find_by(user_id: user_id, likeable_type: likeable_type, likeable_id: likeable_id)

        if check
            check.destroy
        else
            like_post = Like.new(user_id: user_id, likeable_type: likeable_type, likeable_id: likeable_id)
            
            if like_post.save
                ActionCable.server.broadcast(
                    'Like',
                    {
                        action: 'create',
                        type: 'Post',
                        post_id: likeable_id,
                    }
                )
                return like_post 
            end
        end
    end

    private

    attr_accessor :user_id, :likeable_type, :likeable_id
end