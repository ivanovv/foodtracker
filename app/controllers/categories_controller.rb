class CategoriesController < ApplicationController
  before_filter :find_category, :only => [:show, :edit, :update, :destroy]

  def index
    @categories = Category.all(:order => "name ASC")
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(params[:category])
    if @category.save
      flash[:notice] = "Successfully created category."
      redirect_to @category
    else
      render :action => 'new'
    end
  end

  def update
    if @category.update_attributes(params[:category])
      flash[:notice] = "Successfully updated category."
      redirect_to @category
    else
      render :action => 'edit'
    end
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

