class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin

  def view_all
    @users = User.includes(:players)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to view_users_path, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      redirect_to view_all_players_path, notice: 'User was successfully deleted.'
    else
      redirect_to view_users_path, alert: 'Failed to delete user.'
    end
  end

  private

  def require_admin
    unless current_user.admin?
      redirect_to root_path, alert: 'You do not have access to this page.'
    end
  end

  def user_params
    params.require(:user).permit(:email, :role)
  end
end
