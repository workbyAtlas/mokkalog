class UsersController < ApplicationController
  before_action :set_user, except: %i[setting]



  def profile
    if not current_user == @user
      @user.update(views: @user.views + 1)
    end
    @posts = @user.posts.order(created_at: :desc)
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
