class PagesController < ApplicationController
  def index
  end

  def about
  end

  def search
    @query = Post.ransack(params[:q])
    @posts = @query.result(distinct: true)
  end
end
