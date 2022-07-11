class FollowsController < ApplicationController
  before_action :logged_in_user, :find_user, only: %i(following followers)

  def following
    @title = t ".following_title"
    @pagy, @users = pagy @user.following, items: Settings.index.items
    render :show_follow
  end

  def followers
    @title = t ".follower_title"
    @pagy, @users = pagy @user.followers, items: Settings.index.items
    render :show_follow
  end

  private

  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = t ".login_message"
    redirect_to login_url
  end

  def find_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t ".alert_user"
    redirect_to root_path
  end
end
