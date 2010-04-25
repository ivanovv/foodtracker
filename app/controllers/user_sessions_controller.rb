class UserSessionsController < ApplicationController
  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = t(:success_login)
      redirect_to (session[:return_to] || (Day.find_by_date() ? root_url : new_day_path))
      session[:return_to] = nil
    else
      render :action => 'new'
    end
  end

  def destroy
    @user_session = UserSession.find
    @user_session.destroy
    flash[:notice] = t(:success_logout)
    redirect_to root_url
  end
end

