class ApplicationController < ActionController::Base
	#after_action :track_action

	before_action :set_query
	before_action :set_query_brand
	before_action :set_modmin

	def set_modmin
	 if user_signed_in?
	 	if current_user.role.in?(["mod","admin"]) then @auth = true else @auth = false end
	 	if current_user.role.in?(["mod","admin","editor"]) then @auth_e = "editor" else @auth = false end	 		
	 else
	 	@auth = false
	 end
	end

	def set_query
	    @query = Post.ransack(params[:q])	
	end

	def set_query_brand
		@query = Post.ransack(params[:q])	
	end


	def editor?
		return if current_user.editor?
		return if current_user.mod?
		return if current_user.admin?
		redirect_to root_path
	end

	def mod?
		return if current_user.mod?
		return if current_user.admin?
		redirect_to root_path
	end

	protected

end
