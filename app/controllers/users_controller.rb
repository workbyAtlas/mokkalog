class UsersController < ApplicationController
  before_action :set_user

  def profile
    if not current_user == @user
      @user.update(views: @user.views + 1)
    end
    @posts = @user.posts.order(created_at: :desc)
  end

  private

  def set_user
    @user = User.find(params[:id])
    #@user = current_user
  end
end
