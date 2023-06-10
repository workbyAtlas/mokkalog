class CommentsController < ApplicationController
	before_action :authenticate_user!
  	before_action :authenticate_user!

	def create
		@post = Post.find(params[:post_id])
		@comment = @post.comments.create(comment_params)
		@comment.user = current_user

		if @comment.save
			flash[:notice] = "Comment has been created"
			redirect_to post_path(@post)
		else
			flash[:notice] = "Comment has not been created"
			redirect_to post_path(@post)
		end

	end

	def destroy
		@post = Post.find(params[:post_id])
		@comment = @post.comments.find(params[:id])
		@comment.destroy
		redirect_to post_path(@post)
	end

	private

	def comment_params
		params.require(:comment).permit(:body, :c_type, :link)
	end


end
