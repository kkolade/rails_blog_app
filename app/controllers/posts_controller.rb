class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
  end

  def show
    @post = Post.includes(:comments, comments: [:author]).find_by(id: params[:id])
    @comment = Comment.new
    @post_ids = current_user.posts.order(created_at: :asc).pluck(:id)
    @post_index = @post_ids.index(@post.id)

    if @post_index
      @post_number = @post_index + 1
    else
      @post_number = 0
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
      flash[:alert] = "Oosh! Something went wrong. Couldn't create the post!"
      render :new, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
