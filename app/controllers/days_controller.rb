class DaysController < ApplicationController
  navigation :days
  before_filter :require_user
  respond_to :html

  def index
    respond_with(@days = current_user.days.recent)
  end

  def show
    respond_with(@day = current_user.days.date(params[:id].to_date))
  end

  def new
    respond_with(@day = Day.new(:user => current_user))
  end

  def create
    @day = current_user.days.build(params[:day])    
    flash[:notice] = "Successfully created day." if @day.save
    respond_with(@day)
  end

  def edit
    respond_with(@day = current_user.days.date(params[:id].to_date))
  end

  def update
    @day = current_user.days.date(params[:id].to_date)    
    flash[:notice] = "Successfully updated day." if @day.update_attributes(params[:day])
    respond_with(@day)
  end

  def destroy
    @day = current_user.days.date(params[:id].to_date)
    @day.destroy
    flash[:notice] = "Successfully destroyed day."
    redirect_to days_url
  end

  private
  def day
    @day ||= current_user.days.date(params[:id].to_date)
  end
end
