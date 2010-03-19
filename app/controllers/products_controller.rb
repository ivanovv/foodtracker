class ProductsController < ApplicationController
  def index
    if params[:category_id]
      @categories = []
      @categories << Category.find(params[:category_id])
    else
      @categories = Category.search_by_product_name(params[:search])
    end

    options = {
      :order => 'name ASC',
      :per_page => 10,
      :page => params[:page]
    }

    if params[:search]
      options[:conditions] = "name LIKE '%#{params[:search]}%'"
    end

    if params[:category_id]
      if options[:conditions]
        options[:conditions] << " AND "
      else
        options[:conditions] = ""
      end
      options[:conditions]  << "category_id = #{params[:category_id].to_i}"
    end

    @products = Product.paginate(options)
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
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

  def search
  end
end

