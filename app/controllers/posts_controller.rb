class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
  end

  def show
    @user = current_user
    @post = Post.find(params[:id])
    @comments = @post.comments
    @comment = Comment.new
    # @post_number = @user.posts.order(created_at: :asc).pluck(:id).index(@post.id) + 1
    @post_ids = @user.posts.order(created_at: :asc).pluck(:id)
    @post_index = @post_ids.index(@post.id)

    if @post_index
      @post_number = @post_index + 1
    else
      # If the post is not found in the @user's posts, set a default value or display an error message.
      # For example:
      @post_number = 0
      # or
      flash[:alert] = "Post not found in user's posts."
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.author = current_user
    @post.comments_counter = 0
    @post.likes_counter = 0

    if @post.save
      flash[:notice] = 'Post created successfully!'
      redirect_to user_posts_path(current_user)
    else
      flash[:alert] = "Oosh! Something went wrong. Couldn't create post!"
      render :new, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
