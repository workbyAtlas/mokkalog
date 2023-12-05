class ApplicationController < ActionController::Base
	include Pagy::Backend
	#after_action :track_action

	before_action :set_query
	before_action :set_query_brand
	before_action :set_user_roles
	before_action :set_necessary_variables


	before_action :lockdown



	



	def set_user_roles
	 @auth = false
	 @auth_e = false
	 	if user_signed_in?
			if current_user.role.in?(["mod","admin"]) then @auth = true else @auth = false end
			if current_user.role.in?(["mod","admin","editor"]) then @auth_e = "editor" else @auth_e = false end	 		
		else
#
		end
	end

	def set_query
	    @query = Post.ransack(params[:q])	
	end

	def set_query_brand
		@query = Post.ransack(params[:q])	
	end

	def set_necessary_variables
	    @blank = Brand.find(1)

	end

	def set_filter_var
		@categories = Category.all
		@categories_top = @categories.where(subcats: "top")
		@categories_bottom = @categories.where(subcats: "bottom")
		@categories_overwear = @categories.where(subcats: "overwear")
		@categories_headwear = @categories.where(subcats: "headwear")
		@categories_accessory = @categories.where(subcats: "accessory")


	end

	def lockdown
		if user_signed_in?
			return if current_user.editor?
			return if current_user.mod?
			return if current_user.admin?
			redirect_to lockdown_path
		else
			redirect_to lockdown_path
			
		end

	end





	def editor?
		return if current_user.editor?
		return if current_user.mod?
		return if current_user.admin?
		redirect_to root_path
	end

	def mod?
		if user_signed_in?
			return if current_user.mod?
			return if current_user.admin?
			redirect_to root_path
		else
			redirect_to root_path
		end

	end

	def blocker?
		
		redirect_to root_path
	end




	protected

	def post_setter(q)
    	@posts_prior = q.result(distinct: true).includes(:tags, :brand, :category)
    	@posts_prior = @posts_prior.order(views: :desc)
    	@posts = Kaminari.paginate_array(@posts_prior).page(params[:page]).per(20)
	end

end
