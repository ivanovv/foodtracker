class DaysController < ApplicationController
  before_filter :require_user
  respond_to :html

  def index
    @date = params[:month] ? Date.parse(params[:month]) : Date.today
    respond_with(@days = current_user.days.recent.all)
  end

  def show
    respond_with(day)
  end

  def new
    @day = Day.new(:user => current_user)
    @day.enter_date = Date.parse(params[:enter_date])  if params[:enter_date]
    respond_with(@day)
  end

  def create
    flash[:notice] = "Successfully created day." if day.save
    respond_with(@day)
  end

  def edit
    respond_with(day)
  end

  def update
    flash[:notice] = "Successfully updated day." if day.update_attributes(params[:day])
    respond_with(@day)
  end

  def destroy
    day.destroy
    flash[:notice] = "Successfully destroyed day."
    redirect_to days_url
  end

  private
  def day
    @day ||= current_user.days.date(params[:id].to_date).first
  end
end

