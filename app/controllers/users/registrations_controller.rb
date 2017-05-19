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

protected
# Overwrite update_resource to let users to update their user without giving their password
 def update_resource(resource, params)
   if resource.provider == "google_oauth2"
     params.delete("current_password")
     resource.update_without_password(params)
   else
     resource.update_with_password(params)
   end
 end
end
