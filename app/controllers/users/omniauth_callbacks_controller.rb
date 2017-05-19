class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2

    @user = User.from_omniauth(request.env["omniauth.auth"])

    if request.env['omniauth.auth']['info']['first_name']
      @user.first_name = request.env['omniauth.auth']['info']['first_name']
    end

    if request.env['omniauth.auth']['info']['last_name']
      @user.last_name = request.env['omniauth.auth']['info']['last_name']
    end

    @user.save!

    if session[:scale_id].present?

      @scale = Scale.find(session[:scale_id])
      adjectives = ['rad', 'cool', 'amazing', 'radical', 'awesome', 'wonderful', 'insane', 'deep', 'next level']
      @scale.name = @user.email.split('@')[0] + "'s #{adjectives[rand(0..8)]} scale"
      @user.scales.push(@scale)

      # clear session
      session[:scale_id] = nil
    end

    if @user.persisted?
      @scale = @user.scales.last
      sign_in @user
      set_flash_message(:notice, :success, :kind => "Google") if is_navigational_format?
      redirect_to scale_path(@scale)
    else
      session["devise.google_oauth2_data"] = request.env["omniauth.auth"].except("extra")
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
  end
end
