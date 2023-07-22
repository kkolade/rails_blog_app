class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.author = current_user

    if @comment.save
      redirect_to user_post_path(params[:user_id], params[:post_id]), notice: "Comment successfully saved."
    else
      redirect_to user_post_path(params[:user_id], params[:post_id]), alert: "Comment could not be saved."
    end
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end






