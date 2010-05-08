class CategoriesController < ApplicationController
  respond_to :html
  navigation :categories

  before_filter :find_category, :only => [:show, :edit, :update, :destroy]

  def index
    respond_with(@categories = Category.by_name.all)
  end

  def new
    respond_with(@category = Category.new)
  end

  def create
    @category = Category.new(params[:category])
    flash[:notice] = "Successfully created category." if @category.save
    respond_with(@category)
  end

  def update
    flash[:notice] = "Successfully updated category." if @category.update_attributes(params[:category])
    respond_with(@category)
  end

  def destroy
    @category.destroy
    flash[:notice] = "Successfully destroyed category."
    redirect_to categories_url
  end

  private

  def find_category
    @category = Category.find(params[:id])
  end

end

