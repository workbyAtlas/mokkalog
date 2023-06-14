class ApplicationController < ActionController::Base
	before_action :set_query
	before_action :set_query_brand

	def set_query
	    @query = Post.ransack(params[:q])	
	end

	def set_query_brand
		@query = Post.ransack(params[:q])	
	end

end
