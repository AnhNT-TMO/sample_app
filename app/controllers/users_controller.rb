class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find_by params[:id]
    return if @user

    flash[:danger] = t ".alert_user"
    redirect_to root_path
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t ".alert"
      redirect_to root_path
    else
      flash.now[:danger] = t ".alert_not_save"
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(User::UPDATABLE_ATTRS)
  end
end
