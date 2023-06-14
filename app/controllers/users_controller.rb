class UsersController < ApplicationController
  before_action :set_user

  def profile
    @user.update(views: @user.views + 1)
    @posts = @user.posts.order(created_at: :desc)
  end

  private

  def set_user
    @user = User.find(params[:id])
    #@user = current_user
  end
end
