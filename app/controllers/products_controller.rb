require 'iconv'

class ProductsController < ApplicationController
  before_filter :require_user, :only => [:edit, :update, :destroy]
  def index

    #if params[:search]
      #params[:search] = params[:search].force_encoding('utf-8')
      #params[:search] = params[:search]
    #end

    options = default_options

    if params[:category_id]
      @categories = [Category.find(params[:category_id])]
      options[:conditions] = "category_id = #{params[:category_id].to_i}"
    else
      @categories = Category.search_by_product_name(params[:search])
    end

    if params[:search]
      add_and_to_conditions(options)
      options[:conditions] << "name LIKE '%#{params[:search]}%'"
    end

    @products = Product.paginate(options)

    if @products.size == 0  && !params[:category_id] #&& params[:search].chars.length > 3
      find_category_by_name(params[:search])
    end

  end

  def show
    @product = Product.find(params[:id])
  end

  def get_energy
    if request.xhr?
      @product = Product.find(params[:product_id])
      render :text => @product.energy.to_s
    end
  end

  def get_utkonos_link
    @link = CGI.escape(Iconv.conv("WINDOWS-1251", "UTF-8", params[:product_name])) if !params[:product_name].blank?
    @link||= ""
    @link = "http://www.utkonos.ru/search.php?q=" + @link
    respond_to do |format|
      format.js
    end
  end


  def new
    @product = product_with_defaults
    @categories = Category.by_name
  end

  def create
    #params[:product][:name] = params[:product][:name].force_encoding('UTF-8')

    @product = Product.new(params[:product])
    if @product.save
      flash[:notice] = "Successfully created product."
      redirect_to @product
    else
      render :action => 'new'
    end
  end

  def edit
    @product = Product.find(params[:id])
    @categories = Category.by_name
  end

  def update
    @product = Product.find(params[:id])
    if @product.update_attributes(params[:product])
      flash[:notice] = "Successfully updated product."
      redirect_to @product
    else
      render :action => 'edit'
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    flash[:notice] = "Successfully destroyed product."
    redirect_to products_url
  end

  private

  def default_options
    {
      :order => 'name ASC',
      :per_page => 10,
      :page => params[:page]
    }
  end

  def find_category_by_name(category_name)
    category = Category.search_by_name(category_name).first
      if category
        @categories = [category]
        @products = category.products.paginate(default_options)
      end
  end

  def add_and_to_conditions(options)
    if options[:conditions]
      options[:conditions] << " AND "
    else
      options[:conditions] = ""
    end
  end

  def product_with_defaults
    product = Product.new
    product.water = 0
    product.fat = 0
    product.carbohydrate = 0
    product.protein = 0
    product.energy = 0
    product
  end

end

