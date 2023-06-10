class ClosetsController < ApplicationController
  def update
    closet = Closet.where(post: Post.find(params[:post]), user: current_user)
    if closet == []
      Closet.create(post: Post.find(params[:post]), user: current_user)
      @closet_exists = true
    else
      closet.destroy_all
      @closet_exists = false
    end
  end
  respond_to do |format|
    format.html {}
    format.json {}
  end
end
