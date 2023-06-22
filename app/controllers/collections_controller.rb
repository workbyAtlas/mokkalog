class CollectionsController < ApplicationController
  before_action :set_collection, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  before_action :editor?

  # GET /collections or /collections.json
  def index
    @collections = Collection.all
  end

  # GET /collections/1 or /collections/1.json
  def show
  end

  # GET /collections/new
  def new
    @collection = Collection.new
  end

  # GET /collections/1/edit
  def edit
  end

  # POST /collections or /collections.json
  def create
    @collection = Collection.new(collection_params.except(:posts))
    create_or_delete_collections_posts(@collection, params[:collection][:posts])

    respond_to do |format|
      if @collection.save
        format.html { redirect_to collection_url(@collection), notice: "Collection was successfully created." }
        format.json { render :show, status: :created, location: @collection }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @collection.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /collections/1 or /collections/1.json
  def update
    create_or_delete_collections_posts(@collection, params[:collection][:posts])
    respond_to do |format|
      if @collection.update(collection_params.except(:posts))
        format.html { redirect_to collection_url(@collection), notice: "Collection was successfully updated." }
        format.json { render :show, status: :ok, location: @collection }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @collection.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /collections/1 or /collections/1.json
  def destroy
    @collection.destroy

    respond_to do |format|
      format.html { redirect_to collections_url, notice: "Collection was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    def create_or_delete_collections_posts(collection, posts)
      collection.collectibles.destroy_all
      posts = posts.strip.split(',')
      posts.each do |post|
        collection.posts << Post.find_or_create_by(id: post)
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_collection
      @collection = Collection.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def collection_params
      params.require(:collection).permit(:likes, :views, :body, :title, :posts)
    end
end
