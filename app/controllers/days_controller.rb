class DaysController < ApplicationController
  before_filter :require_user
  def index
    @days = Day.all
  end
  
  def show
    @day = Day.find_by_enter_date(params[:id].to_date)
  end
  
  def new
    @day = Day.new
    @day.user_id = current_user.id
  end
  
  def create
    @day = Day.new(params[:day])
    @day.user_id = current_user.id
    if @day.save
      flash[:notice] = "Successfully created day."
      redirect_to @day
    else
      render :action => 'new'
    end
  end
  
  def edit
    @day = Day.find_by_enter_date(params[:id].to_date)
  end
  
  def update
    @day = Day.find_by_enter_date(params[:id].to_date)
    if @day.update_attributes(params[:day])
      flash[:notice] = "Successfully updated day."
      redirect_to @day
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @day = Day.find_by_enter_date(params[:id].to_date)
    @day.destroy
    flash[:notice] = "Successfully destroyed day."
    redirect_to days_url
  end
end
