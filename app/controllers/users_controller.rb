class UsersController < ApplicationController
  def index
    @users = User.includes(:posts).order(created_at: :asc)
  end

  def show; end
end
