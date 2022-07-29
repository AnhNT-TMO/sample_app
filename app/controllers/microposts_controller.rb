class MicropostsController < ApplicationController
  before_action :logged_in_user, only: %i(create destroy)
  before_action :correct_user, only: :destroy

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = t ".create_success"
      redirect_to root_url
    else
      @pagy, @feed_items = pagy current_user.feed
      render "static_pages/home"
    end
  end

  def destroy
    if @micropost.destroy
      flash[:success] = t ".success_destroy"
    else
      flash[:danger] = t ".fail_destroy"
    end
    redirect_to request.referer || root_url
  end

  private

  def micropost_params
    params.require(:micropost).permit(Micropost::CREATEABLE_ATTR)
  end

  def correct_user
    @micropost = current_user.microposts.find_by id: params[:id]
    return if @micropost

    flash[:danger] = t ".flash_danger"
    redirect_to request.referer || root_url
  end
end
