class PagelinksController < ApplicationController
	before_action :authenticate_user!
	before_action :set_post
	
	def create
		@pagelink = @post.pagelinks.create(pagelink_params)
		@pagelink.user = current_user

		if @pagelink.save
			flash[:notice] = "Your link has been created."
			redirect_to post_path(@post)
		else
			flash[:alert] = "Something when wrong."
			redirect_to post_path(@post)
		end

	end

	def destroy
		@pagelink = @post.pagelinks.find(params[:id])
		
		if @pagelink.destroy
			redirect_to post_path(@post), notice: 'Pagelink was successfully deleted.'
		else
			redirect_to post_path(@post), alert: 'Failed to delete pagelink.'
		end
	end

	private

	def set_post
		@post = Post.find(params[:post_id])
	end

	def pagelink_params
		params.require(:pagelink).permit(:body,:web_link,:price)
	end
end
