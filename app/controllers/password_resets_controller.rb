class PasswordResetsController < ApplicationController
  before_action :find_password_reset_user, only: :create
  before_action :find_user, :valid_user, :check_expiration,
                only: %i(edit update)
  before_action :check_params_user_password, only: :update

  def new; end

  def create
    @user.create_reset_digest
    @user.send_password_reset_email
    flash[:info] = t ".info_mail"
    redirect_to root_url
  end

  def update
    if @user.update user_params
      flash[:success] = t ".success_reset"
      redirect_to login_path
    else
      flash.now[:danger] = t ".alert"
      render :new
    end
  end

  def edit; end

  private

  def check_expiration
    return unless @user.password_reset_expired?

    flash[:danger] = t ".alert"
    redirect_to new_password_reset_url
  end

  def find_user
    @user = User.find_by email: params[:email]
    return if @user

    flash[:danger] = t ".not_found"
    redirect_to login_path
  end

  def find_password_reset_user
    @user = User.find_by email: params[:password_reset][:email].downcase
    return if @user

    flash[:danger] = t ".alert_user"
    redirect_to login_path
  end

  def valid_user
    return if @user&.activated? && @user&.authenticated?(:reset, params[:id])

    flash[:danger] = t ".alert_user"
    redirect_to root_url
  end

  def user_params
    params.require(:user).permit(User::PASSWORD_RESET_ATTRS)
  end

  def check_params_user_password
    return unless params[:user][:password].blank?

    @user.errors.add :password, t(".cant_empty")
    render :edit
  end
end
