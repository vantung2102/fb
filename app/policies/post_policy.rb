class PostPolicy < ApplicationPolicy
    attr_reader :user, :post
  
    def initialize(user, post)
      @user = user
      @post = post
    end
  
    def destroy?
      user.is_admin? || user == post.user
    end
end