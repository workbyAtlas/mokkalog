class PagesController < ApplicationController
  before_action :mod?, only: %i[admin_room]


  def index
    @blank = Brand.find(1) 
    #@posts_hot = Post.order(created_at: :asc).limit(4)
    @posts_hot = Post.order(views: :desc).limit(16)
    @posts_latest = Post.order(created_at: :desc).limit(16)

    @posts_picks = Post.where(id: [394,25,285,224]) 
    @posts_inno = Post.where(id: [13, 30, 387, 382])
    @posts_sustain = Post.where(id: [35,19,29,375]) 
    @posts_creator = Post.where(id: [43,23,49,380])

    @post_count = Post.count(:all)
    @brand_showcase = Brand.where(id: [95,45,61,96])
    @subtext = ["New Collection","Hand Made","Shop Today","Hailing from Korea"]
    @brands_test = Brand.where(id:[1,2,3,4])

    


  end

  def about
  end



  def admin_room
    @users =User.all
    @posts =Post.all
  end
end
