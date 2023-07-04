class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy]
  before_action :authenticate_user!, except: %i[index show]

  # GET /posts or /posts.json

  def visit
    @post = Post.find(params[:id])

    
  end

  def index
    #@posts = Post.all
    @q = Post.ransack(params[:q])
    @query = Post.ransack(params[:q])
    @posts = @query.result(distinct: true).includes(:tags, :brands)#.post(params[:post])
    #@posts =@posts.(distinct: true)
    @user_gid = current_user.to_gid_param if current_user
  end

  # GET /posts/1 or /posts/1.json
  def show
    @post.update(views: @post.views + 1)
    @comments =@post.comments.order(created_at: :asc)
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params.except(:tags, :brands))
    create_or_delete_posts_tags(@post, params[:post][:tags],)
    create_or_delete_posts_brands(@post, params[:post][:brands],)
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
    create_or_delete_posts_brands(@post, params[:post][:brands],)
    @post.edited_by = current_user.username

    respond_to do |format|
      if @post.update(post_params.except(:tags, :brands))
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
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
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

  private
    def private_stream
      private_target = "post_#{@post.id} private_likes"
      turbo_stream.replace(private_target, partial: "likes/private_button", locals:{post: @post, like_status: current_user.liked?(@post)})
    end

    def create_or_delete_posts_tags(post, tags)
      post.taggables.destroy_all
      tags = tags.strip.split(',')
      tags.each do |tag|
        tagged =tag.downcase
        post.tags << Tag.find_or_create_by(name: tagged)
      end
    end

    def create_or_delete_posts_brands(post, brands)
      post.brandables.destroy_all
      brand = brands
      if brand = Brand.find_by(name: brands)
        post.brands << Brand.find_or_create_by(name: brands)
      else
        post.brands << Brand.find_or_create_by(name: brands, user_id: current_user.id)
      end

    
    end
  

    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :body, :price, :color, :category, :sub_category, :web_link, :likes, :image, :tags, :brands, :user_id, :c_type, :amazon_link, :material)
    end
end
