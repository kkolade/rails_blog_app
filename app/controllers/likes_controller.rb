class LikesController < ApplicationController
  def create
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
