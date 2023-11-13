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
    @blog_1 = Blog.find(1)
    @blog_2 = Blog.find(9)

    
    @stxt = ["New Collection","Hand Made","Shop Today","Hailing from Korea"]
    if Rails.env.development?
      @brand_s1 = Brand.find(1)
      @brand_s2 = Brand.find(2)
      @brand_s3 = Brand.find(3)
      @brand_s4 = Brand.find(4)
    else
      @brand_s1 = Brand.find(95)
      @brand_s2 = Brand.find(45)
      @brand_s3 = Brand.find(61)
      @brand_s4 = Brand.find(96)
    end  

    


  end

  def about
  end



  def admin_room
    @users =User.all
    @posts =Post.all
    @categories = Category.all
  end
end
