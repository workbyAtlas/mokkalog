# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  #skip_before_action :require_password, only: [:edit]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    if params[:user][:middle_name].present?
    # Handle it as you see fit: render something, or redirect, or just ignore
    redirect_to root_path
    else
      super
    end

  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  #def after_sign_up_path_for(resource)
  #  #posts_path
  #end

  def after_update_path_for(resource)
    user_path(current_user)
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :name, :last_name, :primary_color,:secondary_color,:text_color, :role])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :name, :last_name, :avatar, :link1, :link2,:primary_color,:secondary_color,:text_color, :role, :description, :link1_title, :link2_title ])
  end



  # The path used after sign up.
  #def after_sign_in_path_for(resource)
  #  #super(resource)
  #    if current_user.sign_in_count < 
  #    # Redirect to a custom path for the first sign-in
  #    # For example, you can redirect to a welcome page or an onboarding process
  #      welcome_path
  #    end
  #end

  # The path used after sign up for inactive accounts.
  def after_inactive_sign_up_path_for(resource)
    new_user_confirmation_path
  end
end
