class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by email: params[:email]
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      flash[:success] = t ".activate_success"
      redirect_to login_path
    else
      flash[:danger] = t ".invalid_link"
      redirect_to root_url
    end
  end
end
