class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)

    # create user association if there is a scale_id in the session
    if session[:scale_id].present?

      @scale = Scale.find(session[:scale_id])
      adjectives = ['rad', 'cool', 'amazing', 'radical', 'awesome', 'wonderful', 'insane', 'deep', 'next level']
      @scale.name = current_user.email.split('@')[0] + "'s #{adjectives[rand(0..8)]} scale"
      current_user.scales.push(@scale)

      # clear session
      session[:scale_id] = nil

      #redirect
      flash[:notice] = "Sweet, logged in. Nice scale!"
      scale_path(@scale)
    else
      super
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email, :password, :remember_me])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password, :remember_me])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :username, :email, :password, :current_password, :remember_me])
  end

end
