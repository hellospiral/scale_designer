class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def current_user_home
    redirect_to current_user
  end

  private
  def user_params
    params.require(:user).permit(:username, :first_name, :last_name, :email, :password, :password_confirmation)
  end
end
