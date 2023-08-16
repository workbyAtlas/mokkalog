class UsersController < ApplicationController
  before_action :set_user, except: %i[setting]



  def profile
    if not current_user == @user
      @user.update(views: @user.views + 1)
    end
    @posts = @user.posts.order(created_at: :desc)
    @posts = @posts.order('created_at DESC').page(params[:page]).per(15)
    
    @liked_posts = current_user.liked_posts
  end

  def setting
  end

  private

  def set_user
    @user = User.find(params[:id])
    #@user = current_user
  end


  private
    # Use callbacks to share common setup or constraints between actions.

end
