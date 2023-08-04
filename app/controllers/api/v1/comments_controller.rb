class Api::V1::CommentsController < ApplicationController
  def index
    post = Post.find(params[:post_id])
    comments = post.comments
    render json: comments
  end

  def create
    post = Post.find(params[:post_id])
    user = User.find_by(email: params[:email]) # Assuming you pass user's email in the request
    comment = post.comments.new(user: user, content: params[:content])
    
    if comment.save
      render json: comment, status: :created
    else
      render json: { error: comment.errors.full_messages }, status: :unprocessable_entity
    end
  end
end
