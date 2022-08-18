class Api::V1::PostsController < Api::V1::BaseController

    def like
        like_post = Api::Post::LikePost.call(current_user.id, "Post", params[:idPost])
        
        if like_post
            render json: success_message('Successfully', serializers(like_post, LikePostSerializer))
        else
            render json: error_message('Like falure')
        end
    end

    def comment
        comment = Api::Post::CreateComment.call(current_user.id, params[:content], params[:idPost])
        
        if comment
            ActionCable.server.broadcast(
                'Comment',
                {
                    action: 'create',
                    username: current_user.name,
                    avatar_url: gravatar_for_user(current_user),
                    comment: comment,
                }
            )
            render json: success_message('Successfully', serializers(comment, CommentSerializer))
        else
            render json: error_message('Comment falure')
        end
    end

    def destroy_comment
        destroy = Api::Post::DestroyComment.call(params[:idComment], current_user.id)
        
        if destroy
            ActionCable.server.broadcast(
                "Comment",
                {
                    action: 'destroy',
                    destroy: destroy
                }
            )
            render json: success_message('Successfully', serializers(destroy, CommentSerializer))
        else
            render json: error_message('Comment falure')
        end
    end
end
  