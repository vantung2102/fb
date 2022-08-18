class Api::Post::DestroyComment < ApplicationService
    def initialize(comment_id, user_id)
        @comment_id = comment_id
        @user_id = user_id
    end

    def call
        destroy = Comment.find_by(id: comment_id, user_id: user_id)
        destroy if destroy.destroy
    end

    private

    attr_accessor :comment_id, :user_id
end