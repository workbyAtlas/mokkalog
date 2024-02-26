class UsersController < ApplicationController
  before_action :set_user, except: %i[setting]
  before_action :mod?, only: %i[coin]




  def profile

    if not current_user == @user
      @user.update(views: @user.views + 1)
    end
    @posts = @user.posts.order(created_at: :desc)
    #@posts = @posts.order('created_at DESC').page(params[:page]).per(15)
    

    @closet_post = @user.favorited_posts
    @liked_posts = @user.liked_posts
    @followed_brands = @user.liked_brands

    @collections = @user.collections
    @liked_collection = @user.liked_collections
  end


  def coin
    if @auth
      @user.update(coins: @user.coins + 10)
      redirect_to adroom_path
    end
  
  end


  def setting
  end

  def dashboard
    if current_user.brands.count > 0
      @brands = @user.brands
      if Rails.env.development?
        @brand = Brand.find_by(id: 9)
      else
        @brand = @brands.min_by(&:id)
      end

      @q = @brand.posts.select('posts.*, COUNT(activities.id) AS activities_count')
                       .left_joins(:activities)
                       .group('posts.id')
                       .ransack(params[:q])

      @posts = @q.result(distinct: true).order(activities_count: :desc)

      #@posts = Post.where(brand: @brands).all

    end
  end




  private

  def set_user
    #@user = User.find_by(username: params[:username])
    @user = User.friendly.find(params[:id])
    #@user = current_user
  end




  private
    # Use callbacks to share common setup or constraints between actions.

end
