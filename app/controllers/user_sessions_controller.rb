class UserSessionsController < ApplicationController
  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = t('user_sessions.create.success_login')
      day = Day.find_by_date
      redirect_to (session[:return_to] || (day ? root_url : new_day_path))
      session[:return_to] = nil
    else
      render :action => 'new'
    end
  end

  def destroy
    @user_session = UserSession.find
    if @user_session
      @user_session.destroy
      flash[:notice] = t('user_sessions.destroy.success_logout')
    end
    redirect_to root_url
  end
end

