class HomeController < ApplicationController

  def index
    if params[:search].blank?
      @pagy, @posts = pagy(Post.all.includes(:image_attachment, :user).order(created_at: :desc))
    else
      @pagy, @posts = pagy(Post.includes(:image_attachment, :user).query_search(:content, 
                                                                                  params[:search]).order(created_at: :desc))
      if @posts.blank?
        flash[:danger] = 'not found ' + params[:search]
      else
        flash[:success] = 'The result of ' + params[:search]
      end 
    end
    @user_likes = Like.where(user_id: current_user.id, likeable_type: "Post").group_by(&:likeable_id)

    @post = Post.new
   
  end

  def help;end
end
