require "http"
require 'uri'

class UsersController < ApplicationController
  before_action :authenticate_user!
  after_action :verify_authorized

  def index
    @users = User.all
    authorize @users
  end

  def show
    @user = User.find(params[:id])
    authorize @user
  end

  def updated
    @user = User.find(params[:id])
    authorize @user
    if @user.update_attributes(secure_params)
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end

  def destroy
    user = User.find(params[:id])
    authorize user
    user.destroy
    redirect_to users_path, :notice => "User deleted."
  end

  def login_to_procore
    user = current_user
    authorize user
    redirect_to "https://app.procore.com/oauth/authorize?response_type=code&client_id=" + ENV['PROCORE_CLIENT_ID'] + "&redirect_uri=" + "http://localhost:3000/users/auth/procore/callback" + "&login=gino+admin@procore.com&password=pr0c0re"
  end

  def procore_access_token
    binding.pry
  end

  private

  def secure_params
    params.require(:user).permit(:role)
  end

end
