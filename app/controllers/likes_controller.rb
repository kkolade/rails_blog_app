class LikesController < ApplicationController
  # def create
  #   @like = Like.new
  #   @like.author = current_user
  #   @like.post = Post.find(params[:post_id])
  #   if @like.save
  #     redirect_to user_post_path(user_id: params[:user_id], id: params[:post_id])
  #   else
  #     render :new, status: :unprocessable_entity
  #   end
  # end

  def create
    # @user = current_user
    # @post = @user.posts.find(params[:post_id])
    # @like = Like.new
    # @like.author_id = current_user.id
    # @like.post = Post.find(params[:post_id])

    @user = current_user
    @post = @user.posts.find(params[:post_id])
    @like = Like.new(user_id: current_user.id, post: @post)

    if @like.save
      redirect_to user_post_path(params[:user_id], params[:post_id]), notice: 'like successfully saved.'
    else
      redirect_to user_post_path(params[:user_id], params[:post_id]), alert: 'like could not be saved.'
    end
  end
end
