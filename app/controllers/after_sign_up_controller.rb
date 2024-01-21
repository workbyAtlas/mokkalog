class AfterSignUpController < ApplicationController
	include Wicked::Wizard
	steps :username, :avatar

	def show
		@user = current_user
		@user.current_step = step
		render_wizard		
	end

	def update
		@user = current_user
		

		case step
		when :username
			@user.current_step = step
			@user.update(user_params)
			render_wizard @user
		when :avatar
			@user.update(user_params)
			redirect_to welcome_path
		when :style
			@user.update(user_params)
			redirect_to welcome_path
		end
	end



private


def user_params
  params.require(:user).permit(:name,:username,:last_name)
end


end
