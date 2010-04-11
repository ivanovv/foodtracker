class DaysController < ApplicationController
  before_filter :require_user

  def index
    @days = Day.user(current_user).recent
  end

  def show
    @day = Day.user(current_user).date(params[:id].to_date)
    user = current_user
  end

  def new
    @day = Day.new(:user => current_user)
  end

  def create
    @day = Day.new(params[:day])
    @day.user = current_user
    if @day.save
      flash[:notice] = "Successfully created day."
      redirect_to (session[:return_to] || @day)
    else
      render :action => 'new'
    end
  end

  def edit
    @day = Day.user(current_user).date(params[:id].to_date)
  end

  def update
    @day = Day.user(current_user).date(params[:id].to_date)
    if @day.update_attributes(params[:day])
      flash[:notice] = "Successfully updated day."
      redirect_to @day
    else
      render :action => 'edit'
    end
  end

  def destroy
    @day = Day.user(current_user).date(params[:id].to_date)
    @day.destroy
    flash[:notice] = "Successfully destroyed day."
    redirect_to days_url
  end

  private
  def day
    @day ||= Day.user(current_user).date(params[:id].to_date)
  end
end

