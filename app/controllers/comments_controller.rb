class CommentsController < ApplicationController
  def new
    @user = current_user
    @post = Post.find(params[:post_id])
    @comment = Comment.new
  end

  def create
    @user = current_user
    @post = @user.posts.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.author = @user

    if @comment.save
      flash[:notice] = 'Comment successfully saved.'
    else
      flash[:alert] = 'Comment not saved.'
    end
    redirect_to user_post_path(params[:user_id], params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end
