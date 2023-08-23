class BrandsController < ApplicationController
  before_action :set_brand, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: %i[index show]
  before_action :editing_privilage_brand, only: %i[edit update]


  # GET /brands or /brands.json
  def index
    @query = Brand.ransack(params[:q])
    #brands = @query.result(distinct: true)
    @brands = @query.result.includes(:posts)
    @brands = @brands.order('created_at ASC').page(params[:page]).per(16)



  end

  # GET /brands/1 or /brands/1.json
  def show
    if not current_user == @brand.user
      @brand.update(views: @brand.views + 1)
      #@brand.posts = @brand.posts.order('created_at DESC').page(params[:page]).per(16)
    end
    @posts = @brand.posts.order(created_at: :desc)
    @posts = @posts.order('created_at DESC').page(params[:page]).per(16)
    
    @badges = true
    if @brand.sustainable == "False"
      if @brand.hand_made == "False"
        if @brand.verification == "False"
          @badges = false
        end
      end
    end




  end

  # GET /brands/new
  def new
    @brand = Brand.new
  end

  # GET /brands/1/edit
  def edit

    
  end

  # POST /brands or /brands.json
  def create

    @brand = Brand.new(brand_params)
    @brand.brand_text = "black"
    @brand.user = current_user



    respond_to do |format|
      if @brand.save
        format.html { redirect_to brand_url(@brand), notice: "Brand was successfully created." }
        format.json { render :show, status: :created, location: @brand }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @brand.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /brands/1 or /brands/1.json
  def update
    respond_to do |format|
      if @brand.update(brand_params)
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
    Post.where(brand_id: brand.id).update_all(brand_id: nil)
    brand.destroy
    redirect_to brands_path, notice: 'Brand was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_brand
      @brand = Brand.find(params[:id])
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
       :style, :verification, :location, :x_twitter, :sustainable, :hand_made)
    end
end
