class CommentsController < ApplicationController
	before_action :authenticate_user!
	#efore_action :set_comment


	def create
		@commentable = find_commentable
		@comment = @commentable.comments.build(comment_params)
		@comment.user = current_user

		if @comment.save
			flash[:notice] = "Comment has been created"
			redirect_to @commentable
		else
			flash[:notice] = "Comment has not been created"
			redirect_to @commentable
		end

	end

	def edit
		#@post = Post.find(params[:id])
		@comment = Comment.find(params[:id])
		#@post = Post.find(params[:post_id])
		#@comment = @post.comments.find(params[:id])
		#@commentable = find_commentable
		#@comment = @commentable.comments.build(comment_params)
	
	end

	def update
		#@post = Post.find(params[:post_id])
        #@comment = @post.comments.find(params[:id])
    	@comment = Comment.find(params[:id])
		if @comment.update(comment_params)
			commentable = @comment.commentable_type.constantize.find(@comment.commentable_id)
			redirect_to polymorphic_path(commentable),notice: "Comment has been updated."
		end
		

	end


	def destroy
		#@post = Post.find(params[:post_id])
		#@comment = @post.comments.find(params[:id])
		#@comment.destroy
		#redirect_to post_path(@post)

		@comment = Comment.find(params[:id])
		commentable = @comment.commentable_type.constantize.find(@comment.commentable_id)
		@comment.destroy
		redirect_to polymorphic_path(commentable),notice: "Comment has been removed."
		#redirect_to post_path(post)
	end

	private

	def find_commentable
		#Differietiate between parents models
		params.each do |name, value|
			if name =~ /(.+)_id$/
				return $1.classify.constantize.find(value)
			end
		end
	end

	def comment_params
		params.require(:comment).permit(:body, :c_type, :link, :image)
	end


end
