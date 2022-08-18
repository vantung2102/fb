class Api::Post::CreateComment < ApplicationService
    def initialize(user_id, content, post_id)
        @user_id = user_id
        @content = content
        @post_id = post_id
    end

    def call
        comment = Comment.new(user_id: user_id, content: content, post_id: post_id)
        comment if comment.save
    end

    private

    attr_accessor :user_id, :content, :post_id
end