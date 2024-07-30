class PagesController < ApplicationController
  before_action :mod?, only: %i[admin_room]
 


  def index
    @blank = Brand.find(1) 
    #@posts_hot = Post.order(created_at: :asc).limit(4)
    @posts_hot = Post.order(views: :desc).limit(16)
    @posts_latest = Post.order(created_at: :desc).limit(16)

    @posts_picks = Post.where(id: [394,25,918,224]) 
    @posts_inno = Post.where(id: [13, 30, 387, 382])
    @posts_sustain = Post.where(id: [35,19,29,375]) 
    @posts_creator = Post.where(id: [43,23,612,380])

    @post_count = Post.count(:all)

    @stxt = ["Guess Collab","Hand Made","Preppy","From UK","E-Sports"]
    if Rails.env.development?
      @brand_s1 = Brand.find(1)
      @brand_s2 = Brand.find(2)
      @brand_s3 = Brand.find(3)
      @brand_s4 = Brand.find(4)
      @brand_s5 = Brand.find(5)
      @blog_1 = Blog.find(1)
      @blog_2 = Blog.find(2)
      @blog_3 = Blog.find(3)
    else
      @brand_s1 = Brand.find(95)
      @brand_s2 = Brand.find(45)
      @brand_s3 = Brand.find(101)
      @brand_s4 = Brand.find(104)
      @brand_s5 = Brand.find(102)
      @blog_1 = Blog.find(1)
      @blog_2 = Blog.find(9)
      @blog_3 = Blog.find(11)
    end  

    


  end

  def about
  end

  def after_sign
    sleep(1)
    redirect_to root_path
  end

  def manage
    if current_user.brands.count > 0
      @brands = current_user.brands
      @brand = @brands.min_by(&:id) 
      @posts = Post.where(brand: @brands).all
      @top_posts = @posts.order(views: :desc).limit(4)
      target_brand = @brand  # Assuming @brand is your target brand
      all_brands = Brand.where.not(id: target_brand.id)

      @top_similar_brands = all_brands.max_by(4){ |brand| target_brand.similarity_to(brand) }
      @top_different_brands = all_brands.max_by(4) { |brand| target_brand.dissimilarity_to(brand) }
    end


    #Find Similar Brand

  end

  def admin_room
    @users =User.all
    @posts =Post.all
    @demo_account =User.find_by(email: 'demo@mokkalog.com')
    @categories = Category.all
    # Assuming you have a User model with a 'confirmed_at' attribute
    @confirmed = User.where.not(confirmed_at: nil).count

  end

  def lockdown
  end


  def merry
  end

end
