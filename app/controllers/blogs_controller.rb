class BlogsController < ApplicationController
  before_action :set_blog, only: %i[ show edit update destroy ]
  before_action :mod?, except: %i[show index dev article]
  before_action :authenticate_user!, except: %i[index show]

  # GET /blogs or /blogs.json
  def index
    @blogs = Blog.all
    @blogs_dev = Blog.where(blog_type: "dev")
    @blogs_article = Blog.where(blog_type: "article")
    @blogs_pinned = Blog.where(pinned: "true")
  end

  def dev
    @blogs_dev = Blog.where(blog_type: "dev")

  end

  def article
    @blogs_article = Blog.where(blog_type: "article")
  end

  # GET /blogs/1 or /blogs/1.json
  def show
    @comments =@blog.comments.order(created_at: :asc)
  end

  # GET /blogs/new
  def new
    @blog = Blog.new
  end

  # GET /blogs/1/edit
  def edit
  end

  # POST /blogs or /blogs.json
  def create
    @blog = Blog.new(blog_params)
    @blog.user = current_user

    respond_to do |format|
      if @blog.save
        format.html { redirect_to blog_url(@blog), notice: "Blog was successfully created." }
        format.json { render :show, status: :created, location: @blog }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blogs/1 or /blogs/1.json
  def update
    respond_to do |format|
      if @blog.update(blog_params)
        format.html { redirect_to blog_url(@blog), notice: "Blog was successfully updated." }
        format.json { render :show, status: :ok, location: @blog }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blogs/1 or /blogs/1.json
  def destroy
    @blog.destroy

    respond_to do |format|
      format.html { redirect_to blogs_url, notice: "Blog was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blog
      @blog = Blog.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def blog_params
      params.require(:blog).permit(:title, :text, :pinned, :blog_type, :user_id, :cover)
    end
end
