# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    redirect_to root_path
  end

  # DELETE /resource/sign_out
  def destroy
    if current_user.email == "demo@mokkalog.com"
      current_user.update(name: nil)
      current_user.update(username: nil)
      current_user.update(last_name: nil)
      current_user.posts.destroy_all
      current_user.brands.destroy_all
      super
    else
      super
    end

  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  def after_sign_in_path_for(resource)
    #super(resource)
      # Redirect to a custom path for the first sign-in
      # For example, you can redirect to a welcome page or an onboarding process
    if current_user.onboard == 0
      # Redirect to a custom path for the first sign-in
      # For example, you can redirect to a welcome page or an onboarding process
      current_user.update(onboard: 1)
      after_sign_up_path(:username)
    else
      if current_user.email = "demo@mokkalog.com"
        current_user.update(tokens:1)
        current_user.update(coins:10)
        demo_path
      else
        root_path
      end
    end
  
  end
end