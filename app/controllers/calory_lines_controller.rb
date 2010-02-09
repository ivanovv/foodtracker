class CaloryLinesController < ApplicationController
  def index
    if params[:day_id]
      @day = Day.find_by_enter_date(params[:day_id].to_date)
      if @day
        @calory_lines = @day.calory_lines
      else
        redirect_to new_day_path
        @calory_lines = []
      end	
    else
      @calory_lines = CaloryLine.all
    end
  end
  
  def show
    @calory_line = CaloryLine.find(params[:id])
  end
  
  def new
    @calory_line = CaloryLine.new
    @day = Day.find_by_enter_date(Date.today)
    if @day
      @calory_line.day_id = @day.id
    end
  end
  
  def create
    @calory_line = CaloryLine.new(params[:calory_line])
    if @calory_line.save
      flash[:notice] = "Successfully created calory line."
      redirect_to @calory_line
    else
      render :action => 'new'
    end
  end
  
  def edit
    @calory_line = CaloryLine.find(params[:id])
  end
  
  def update
    @calory_line = CaloryLine.find(params[:id])
    if @calory_line.update_attributes(params[:calory_line])
      flash[:notice] = "Successfully updated calory line."
      redirect_to @calory_line
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @calory_line = CaloryLine.find(params[:id])
    @calory_line.destroy
    flash[:notice] = "Successfully destroyed calory line."
    redirect_to calory_lines_url
  end
end
