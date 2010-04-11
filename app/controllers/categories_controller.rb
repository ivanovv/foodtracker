class CategoriesController < ApplicationController
  respond_to :html

  def index
    respond_with(@categories = Category.by_name.all)
  end

  def show
    @category = Category.find(params[:id])
  end

  def new
    respond_with(@category = Category.new)
  end

  def create
    @category = Category.new(params[:category])
    flash[:notice] = "Successfully created category." if @category.save
    respond_with(@category)
  end

  def edit
    respond_with(@category = Category.find(params[:id]))
  end

  def update
    @category = Category.find(params[:id])
    flash[:notice] = "Successfully updated category." if @category.update_attributes(params[:category])
    respond_with(@category)
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    flash[:notice] = "Successfully destroyed category."
    redirect_to categories_url
  end
end

