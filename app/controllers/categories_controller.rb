class CategoriesController < ApplicationController
  before_action :set_category, only: %i[ show edit update destroy ]
  before_action :mod?, except: %i[show index]
  before_action :authenticate_user!, except: %i[index show]


  
  

  # GET /categories or /categories.json
  def index
    @categories = Category.all
  end

  # GET /categories/1 or /categories/1.json
  def show
  @query = @category.posts.ransack(params[:q])
  post_setter(@query)


  



  # Assuming @posts is a collection of Post objects
  #@brands = @posts.map(&:brand).uniq.compact
  @brands = Brand.where(id: @posts.pluck(:brand_id).uniq.compact)


  #@brands = @brands.order("LOWER(name)")
  @styles = Style.joins(:brands).where(brands: { id: @brands.map(&:id) }).distinct

  better_filter_var
  @locations = @brands.pluck(:location).reject(&:blank?).uniq
  brands_us = @brands.where(location: "US")
  @states = brands_us.pluck(:state).reject(&:blank?).uniq

  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories or /categories.json
  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to category_url(@category), notice: "Category was successfully created." }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1 or /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to category_url(@category), notice: "Category was successfully updated." }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1 or /categories/1.json
  def destroy
    @category.destroy

    respond_to do |format|
      format.html { redirect_to categories_url, notice: "Category was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def category_params
      params.require(:category).permit(:name, :subcats)
    end
end
