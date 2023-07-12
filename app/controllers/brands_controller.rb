class BrandsController < ApplicationController
  before_action :set_brand, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: %i[index show]

  # GET /brands or /brands.json
  def index
    @query = Brand.ransack(params[:q])
    #brands = @query.result(distinct: true)
    @brands = @query.result.includes(:posts)
    @brands = @brands.order('created_at DESC').page(params[:page]).per(16)

  end

  # GET /brands/1 or /brands/1.json
  def show
    if not current_user == @brand.user
      @brand.update(views: @brand.views + 1)
      #@brand.posts = @brand.posts.order('created_at DESC').page(params[:page]).per(16)
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

    # Only allow a list of trusted parameters through.
    def brand_params
      params.require(:brand).permit(:name, :image, :user_id, :body, :views, :link, :banner,
       :brand_color, :brand_text, :header, :last_edited, :ig_link, :gallery1,:gallery2,:gallery3)
    end
end
