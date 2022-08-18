class Post::Search < ApplicationService
    def initialize(search_params)
      @search_params = search_params
    end
  
    def call

      if search_params.nil?
        
        binding.pry
        
        @pagy, @posts = pagy(Post.all.includes(:image_attachment, :user).order(created_at: :desc))
        [pagy, posts, message = nil]
      else
        
        binding.pry
        
        @pagy, @posts = pagy(Post.includes(:image_attachment, :user).query_search(:content, search_params).order(created_at: :desc))
        message = (posts.blank? ? 'not found ' : 'The result of ') + search_params
        [pagy, posts, message]
      end
    end
  
    private
  
    attr_accessor :search_params
  end
  