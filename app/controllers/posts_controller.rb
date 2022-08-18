class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]

  # GET /posts or /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1 or /posts/1.json
  def show;end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit;end

  # POST /posts or /posts.json
  def create
    @post = current_user.posts.build(post_params)
      if @post.save
        flash[:success] = 'Micro post was successfully created.'
        redirect_to(root_url)
      else
        flash[:danger] = 'Micro post was error created.'
        redirect_to(root_url)
      end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    authorize @post
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: "Post was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    authorize @post
    if @post.destroy
      flash[:success] = 'Post was successfully destroyed.'
      redirect_to(root_url)
    else
      flash[:danger] = 'Post was error destroyed.'
      redirect_to(root_url)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :content, :image)
    end
end
