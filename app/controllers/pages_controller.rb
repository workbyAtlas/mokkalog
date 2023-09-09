class PagesController < ApplicationController
  before_action :mod?, only: %i[admin_room]


  def index
    @blank = Brand.find(1) 
    #@posts_hot = Post.order(created_at: :asc).limit(4)
    @posts_hot = Post.order(views: :desc).limit(16)
    @posts_latest = Post.order(created_at: :desc).limit(16)
    @posts_innovative = Post.where(id: [13, 30, 385, 382])
    @posts_sustain = Post.where(id: [35,19,29,375]) 
    @posts_art = Post.where(id: [47,25,7,194]) 
    @posts_culture = Post.where(id: [43,23,49,50])

    


  end

  def about
  end



  def admin_room
    @users =User.all
    @posts =Post.all
  end
end
