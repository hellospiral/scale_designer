class Users::RegistrationsController < Devise::RegistrationsController
  def new
    if params[:scale_id]
      session[:scale_id] = params[:scale_id]
    end
    super
  end

  def create
    super
  end

  def update
    super
  end
end
