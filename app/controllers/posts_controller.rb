class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update]
  #before_action :authenticate_user!, except: %i[index show]
  before_action :editing_privilage_post, only: %i[edit update]

  # GET /posts or /posts.json

  def visit
    @post = Post.find(params[:id])

    
  end

  def home

    @query = Post.ransack(params[:q])
    @posts = @query.result(distinct: true).includes(:tags, :brand, :category)
    

  end

  def index
 
    @brands = Brand.all
    @brands = @brands.order("LOWER(name)")


    @blank = Brand.find(1) 
    @categories = Category.all
    @styles = Style.all

    #Ransack and Pagy
    @query = Post.ransack(params[:q])
    @posts_prior = @query.result(distinct: true).includes(:tags, :brand, :category)
    shuffled_posts = @posts_prior.to_a.shuffle
    @posts = Kaminari.paginate_array(shuffled_posts).page(params[:page]).per(16)

    #Turbo
    respond_to do |format|
      format.html
      format.turbo_stream # This is the key part for Turbo Streams
    end

  end

  # GET /posts/1 or /posts/1.json
  def show
    @blank = Brand.find(1)

    if not current_user == @post.user
      @post.update(views: @post.views + 1)
    end

    @comments =@post.comments.order(created_at: :asc)
    @pagelinks = @post.pagelinks.order(created_at: :asc)
    @badges = false

    if @post.brand.verification == "True"
      @badges = true
    end

    @verified_post = false
    if @post.user == @post.brand.user
      @verified_post = true
    end
    
    if @post.brand.verification == "True"
      if @post.user.role = "admin"
        @verified_post = true
      end
      if @post.user.role = "mod"
        @verified_post = true
      end
    end

    @visit_modal = false

    if @pagelinks.count > 0
      @visit_modal = true
    end

    #Building Recommendation Algo
    set_recommendation



  end

def quick
  @post = Post.find(params[:id])
  if not current_user == @post.user
    @post.update(views: @post.views + 1)
  end 
  

  #@new_web_link = @post.web_link.start_with?('http://', 'https://') ? @web_link : "https://#{@web_link}"

  end

  # GET /posts/new
  def new
    @post = Post.new
    #@user_brands = current_user.brands
    set_users_brand


  end

  # GET /posts/1/edit
  def edit
    set_users_brand
    
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params.except(:tags))
    create_or_delete_posts_tags(@post, params[:post][:tags],)
    #create_or_delete_posts_brands(@post, params[:post][:brands],)
    @post.user = current_user

    respond_to do |format|
      if @post.save
        format.html { redirect_to post_url(@post), notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    create_or_delete_posts_tags(@post, params[:post][:tags],)
    #create_or_delete_posts_brands(@post, params[:post][:brands],)
    @post.edited_by = current_user.username

    respond_to do |format|
      if @post.update(post_params.except(:tags))
        format.html { redirect_to post_url(@post), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to root_path, notice: 'Post was successfully destroyed.'
  end

  def subcat
    @subcat
  end

  def like
    @post = Post.find(params[:id])
    current_user.like(@post)
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: private_stream
      end
    end
    #redirect_to posts_url
  end

  def favorite

    @post = Post.find(params[:id])
    if current_user.favorited?(@post)
      current_user.favorite(@post)
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: private_fav_stream
        end
      end
    else

      if current_user.favorited_posts.count < 8
        current_user.favorite(@post)
        respond_to do |format|
          format.turbo_stream do
            render turbo_stream: private_fav_stream
          end
        end
      else
        respond_to do |format|
          format.html { redirect_to post_url(@post), alert: "You already have 8 in your closet, please remove one to add it." }
          format.json { render :show, status: :ok, location: @post }
        end
      end


    end

  end

  def check
    #redirect_to request.url, notice: Time.zone.now
    @check_post = Post.new(post_params.except(:tags, :brands))
    respond_to do |format|
      format.turbo_stream
    end
  end

  private

    def set_users_brand
      if @auth_e
      @user_brands = Brand.all
      else
      @user_brands = current_user.brands + Brand.where(id: 1)
      end

    end

    def private_stream
      private_target = "post_#{@post.id} private_likes"
      turbo_stream.replace(private_target, partial: "likes/private_button", locals:{post: @post, like_status: current_user.liked?(@post)})
    end

    def private_fav_stream
      private_target = "post_#{@post.id} private_favs"
      turbo_stream.replace(private_target, partial: "posts/components/favorite_btn", locals:{post: @post, fav_status: current_user.favorited?(@post)})
    end

    def editing_privilage_post
      return if current_user.editor?
      return if current_user.mod?
      return if current_user.admin?
      return if current_user == @post.user
      return if current_user == @post.brand.user
      redirect_to root_path
    end

    def create_or_delete_posts_tags(post, tags)
      post.taggables.destroy_all
      tags = tags.downcase.strip.split(',')
      tags.each do |tag|
        post.tags << Tag.find_or_create_by(name: tag)
      end
    end

    def set_recommendation
    post_brand = @post.brand
      @similar_posts = Post.where(category_id: @post.category_id, color: @post.color)
                     .where.not(id: @post.id).order('RANDOM()').limit(16)
      num_similar_posts = @similar_posts.count

      # If there are less than 16 similar posts, fill the rest with posts from the same category
      if num_similar_posts < 16
        remaining_posts = Post.where(category_id: @post.category_id)
                             .where.not(id: [@post.id] + @similar_posts.pluck(:id))
                             .order('RANDOM()')
                             .limit(16 - num_similar_posts)

      @similar_posts += remaining_posts
      end
      # Check how many similar posts have been retrieved
      num_similar_posts = @similar_posts.count

      # If there are less than 16 similar posts, fill the rest with random posts
      if num_similar_posts < 16
        remaining_posts = Post.where.not(id: [@post.id] + @similar_posts.pluck(:id))
                             .order('RANDOM()')
                             .limit(16 - num_similar_posts)

        @similar_posts += remaining_posts
      end

      # Find 8 other posts with the same brand, excluding the current post
      @all_brand = true
      @post_same_brand = Post.where(brand: post_brand).where.not(id: @post.id).order('RANDOM()').limit(16)

      if @post_same_brand.length < 16
        @all_brand = false
        # Access the styles through @post.brand
        styles = @post.brand.styles.pluck(:id)

        # Fetch additional posts with matching styles, excluding the current post and those already fetched
        additional_posts = Post.joins(brand: :styles)
                             .where('styles.id IN (?) AND posts.id NOT IN (?)', styles, [@post.id] + @post_same_brand.pluck(:id))
                             .order('RANDOM()')
                             .limit(16 - @post_same_brand.length)

        # Add these additional posts to the @post_same_brand array
        @post_same_brand += additional_posts
      end

      if @post_same_brand.length < 16
        remaining_posts = Post.where.not(id: [@post.id] + @post_same_brand.pluck(:id))
                             .order('RANDOM()')
                             .limit(16 - num_similar_posts)

        @post_same_brand += remaining_posts
      end


    end 

  

    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.friendly.find(params[:id])

      if params[:id] != @post.slug
        return redirect_to @post, :status => :moved_permanently
      end

    end



    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :body, :price, :color, :category_id, :sub_category, :web_link, :likes, :image, :tags, :brand_id, 
        :name, :user_id, :c_type, :amazon_link, :material, :image1, :image2, :image3, :archive, :grailed, :season)


    end
end
