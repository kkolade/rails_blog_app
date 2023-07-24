class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @user = current_user
    # @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.author = @user

    if @comment.save
      flash[:notice] = "Comment successfully saved."
      redirect_to user_post_path(params[:user_id], params[:post_id])
    else
      flash[:notice] = "Comment not saved."
      redirect_to user_post_path(params[:user_id], params[:post_id])
    end
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end
