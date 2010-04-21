class DaysController < ApplicationController
  before_filter :require_user

  def index
    @days = current_user.days.all(:order => 'enter_date DESC')
  end

  def show
    @day = current_user.days.find_by_date(params[:id].to_date)
  end

  def new
    @day = Day.new(:user => current_user)
  end

  def create
    @day = current_user.days.build(params[:day])
    if @day.save
      flash[:notice] = "Successfully created day."
      redirect_to (session[:return_to] || @day)
    else
      render :action => 'new'
    end
  end

  def edit
    @day = current_user.days.find_by_date(params[:id].to_date)
  end

  def update
    @day = current_user.days.find_by_date(params[:id].to_date)
    if @day.update_attributes(params[:day])
      flash[:notice] = "Successfully updated day."
      redirect_to @day
    else
      render :action => 'edit'
    end
  end

  def destroy
    @day = current_user.days.find_by_date(params[:id].to_date)
    @day.destroy
    flash[:notice] = "Successfully destroyed day."
    redirect_to days_url
  end

  private
  def day
    @day ||= current_user.days.find_by_date(params[:id].to_date)
  end
end

