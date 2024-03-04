class BrandsController < ApplicationController
  before_action :set_brand, only: %i[ show edit update destroy analysis]
  before_action :authenticate_user!, except: %i[index show]
  before_action :editing_privilage_brand, only: %i[edit update]



  # GET /brands or /brands.json
  def index
    
    #brands = @query.result(distinct: true)
    @blank_brands = []
    new_brands = []
    Brand.all.each do |brand|
      if brand.posts.count == 0
        @blank_brands << brand
      else
        new_brands << brand
      end
    end
    new_brand_ids = new_brands.map(&:id) # Extract brand IDs
    @query = Brand.where(id: new_brand_ids).ransack(params[:q])
    @brands_prior = @query.result(distinct: true).includes(:tags, :posts, :styles).order(created_at: :desc)
    @brands = Kaminari.paginate_array(@brands_prior).page(params[:page]).per(20)
    #@brands = @brands.order('created_at ASC').page(params[:page]).per(16)
    @blank = Brand.find(1)

    @styles = Style.all
    @locations = new_brands.pluck(:location).reject(&:blank?).uniq

    
    brands_us = new_brands.select { |brand| brand.location == "US" }

    @states = brands_us.pluck(:state).reject(&:blank?).uniq
    #@c = Countries['US']


    


  end

  # GET /brands/1 or /brands/1.json
  def show

    @blank = Brand.find(1) 
    @c = ISO3166::Country.new(@brand.location)


    if not current_user == @brand.user
      @brand.update(views: @brand.views + 1)
      #@brand.posts = @brand.posts.order('created_at DESC').page(params[:page]).per(16)
    end

    @query = @brand.posts.ransack(params[:q])
    #@query = @brand.posts.order(created_at: :desc)
    @posts_prior = @query.result(distinct: true).includes(:tags, :brand, :category)
    @posts_prior = @posts_prior.order(views: :desc)
    @posts = Kaminari.paginate_array(@posts_prior).page(params[:page]).per(20)

    better_filter_var
    
    @styles = Style.all



    
    
    @badges = false

    if @brand.verification == "True"
      @badges = true
    end

    #Gallery
    @gallery = false
    @gallery = true if @brand.gallery1.attached?
    @gallery = true if @brand.gallery2.attached?
    @gallery = true if @brand.gallery3.attached?

    # For Analytics
    @top_posts = @posts_prior.order(views: :desc).limit(4)

    @posts_chart = Post.where(brand: @brand).all
    target_brand = @brand  # Assuming @brand is your target brand
    all_brands = Brand.where.not(id: target_brand.id)

    @top_similar_brands = all_brands.sort_by { |brand| target_brand.similarity_to(brand) }.reverse.take(4)
    @top_different_brands = all_brands.max_by(4) { |brand| target_brand.dissimilarity_to(brand) }



  end


  # GET /brands/1/edit
  def edit

    
  end

  # POST /brands or /brands.json
  def create
    

    @brand = Brand.new(brand_params.except(:tags))

    @brand.brand_text = "#654321;"
    @brand.user = current_user
    #delete_styles(@brand, params[:brand][:styles],)
    current_user.tokens -= 1

    respond_to do |format|
      if @brand.save
        current_user.save
        session[:brand_id] = @brand.id
        format.html { redirect_to brand_onboarding_path(:image), notice: "Brand was successfully created." }
        #format.json { render :show, status: :created, location: @brand }

      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @brand.errors, status: :unprocessable_entity }
      end
    end
  end

  def new
    if current_user.tokens > 0
      @brand = Brand.new
    else
      redirect_to root_path, notice: "You don't have any Brand Token left, please reach out to our admins."

    end

  end

  # PATCH/PUT /brands/1 or /brands/1.json
  def update
    if @auth
      create_or_delete_brands_tags(@brand, params[:brand][:tags])
    end


    delete_styles(@brand, params[:brand][:styles],)


 
    respond_to do |format|

      if @brand.update(brand_params.except(:tags))
        @brand.last_edited = current_user.username
        format.html { redirect_to brand_url(@brand), notice: "Brand was successfully updated." }
        format.json { render :show, status: :ok, location: @brand }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @brand.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /brands/1 or /brands/1.json
  def destroy
    brand = Brand.find(params[:id])
    #Post.where(brand_id: brand.id).update_all(brand_id: nil)
    brand.destroy
    redirect_to brands_path, notice: 'Brand was successfully destroyed.'
  end

  def analysis

    @q = @brand.posts.ransack(params[:q])
    #@query = @brand.posts.order(created_at: :desc)
    @posts_prior = @q.result(distinct: true).includes(:tags, :brand, :category)
    @posts = @posts_prior.order(views: :desc)


    @activities = Activity.includes(:post).where(post_id: @posts.map(&:id))

  end

  def like
    @brand = Brand.find(params[:id])
    if current_user.liked?(@brand)
      current_user.unlike(@brand)
    else
      current_user.like(@brand)
    end

    respond_to do |format|
      format.html { redirect_to brand_path(@brand) }
    end
  end

  def purge_banner
    @brand = Brand.find(params[:id])
    @brand.banner.purge
    redirect_back fallback_location: brands_path, notice: "Success"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_brand
      @brand = Brand.friendly.find(params[:id])
      if params[:id] != @brand.slug
        return redirect_to @brand, :status => :moved_permanently
      end
    end

    def delete_styles(brand, styles)
      brand.styleables.destroy_all
      if not styles.nil?
      #styles = styles.strip.split(',')
        styles.each do |style|
          brand.styles << Style.find_or_create_by(name: style)
        end
      end
    end



    def private_stream
      private_target = "brand_#{@brand.id}_private_likes"
      turbo_stream.replace(private_target, partial: "brands/components/like_button", locals:{brand: @brand, like_status: current_user.liked?(@brand)})
    end

    # GET /brands/new

    def create_or_delete_brands_tags(brand, tags)
      brand.brand_tag_assocs.destroy_all
    
      tags = tags.strip.split(',')
      tags.each do |tag|
        brand.tags << Tag.find_or_create_by(name: tag)
      end

    end







    def editing_privilage_brand
      return if current_user.editor?
      return if current_user.mod?
      return if current_user.admin?
      return if current_user == @brand.user
      redirect_to root_path
    end
    # Only allow a list of trusted parameters through.
    def brand_params
      params.require(:brand).permit(:name, :image, :user_id, :body, :views, :link, :banner,
       :brand_color, :brand_text, :header, :last_edited, :ig_link, :gallery1,:gallery2,:gallery3,
       :styles, :verification, :location, :x_twitter, :badge, :likes,:state)
    end
end
