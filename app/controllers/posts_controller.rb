class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
  end

  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
    @posts = @user.posts
    @post_number = @user.posts.order(created_at: :asc).pluck(:id).index(@post.id) + 1
  end

  def new
    @post = Posts.new
  end
end
