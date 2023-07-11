class PagesController < ApplicationController
  before_action :mod?, only: %i[admin_room]


  def index
    @posts_hot = Post.order(ceated_at: :asc).limit(4)
    #@posts_hot = Post.order(views: :desc).limit(4)
    @posts_latest = Post.order(created_at: :desc).limit(4)


  end

  def about
  end



  def admin_room
    @users =User.all
    @posts =Post.all
  end
end
