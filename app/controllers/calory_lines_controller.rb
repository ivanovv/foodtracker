class CaloryLinesController < ApplicationController

  before_filter :require_user, :get_day, :get_product

  def index
    if params[:day_id]
      if @day
        @calory_lines = @day.calory_lines
      else
        redirect_to new_day_path
        @calory_lines = []
      end
    else
      @calory_lines = CaloryLine.user_full(current_user)
    end
    @total_calories = @calory_lines.inject(0) { |sum, calory_line| sum + calory_line.total_calories }
  end

  def show
    @calory_line = CaloryLine.find(params[:id])
  end

  def new
    @calory_line = CaloryLine.new
    @user_days = current_user.days.recent
    if params[:day_id]
      if @day
        @calory_line.day_id = @day.id
      else
        store_location
        redirect_to new_day_path
      end
    else
      @calory_line.day_id = @today.id if @today
    end

    if params[:product_id]
      if @product
        @calory_line.product_id = @product.id
        @calory_line.energy = @product.energy
      else
        flash[:notice] = "Product not found!"
        redirect_to products_path
      end
    end

    @calory_line.net_weight = params[:net_weight].to_f if params[:net_weight]
  end

  def create
    @calory_line = CaloryLine.new(params[:calory_line])
    @calory_line.energy ||= @calory_line.product.energy
    if @calory_line.save
      flash[:notice] = "Successfully created calory line."
      redirect_to @calory_line
    else
      render :action => 'new'
    end
  end

  def edit
    @calory_line = CaloryLine.find(params[:id])
    @user_days = current_user.days.recent
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

    redirect_to @day ? day_calory_lines_path(@day) :calory_lines_url
  end

  private

  def get_day
    @day, @today = nil, nil
    if params[:day_id]
      @day = Day.find_by_date(params[:day_id].to_date)
    else
      @today = Day.find_by_date()
    end
  end

  def get_product
    @product = Product.find(params[:product_id]) if params[:product_id]
  end

end

