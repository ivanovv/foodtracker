class ProductsController < ApplicationController
  def index

    #if params[:search]
      #params[:search] = params[:search].force_encoding('utf-8')
      #params[:search] = params[:search]
    #end

    options = default_options

    if params[:category_id]
      @categories = []
      @categories << Category.find(params[:category_id])
      options[:conditions]  = "category_id = #{params[:category_id].to_i}"
    else
      @categories = Category.search_by_product_name(params[:search])
    end

    if params[:search]
      if options[:conditions]
        options[:conditions] << " AND "
      else
        options[:conditions] = ""
      end

      options[:conditions] << "name LIKE '%#{params[:search]}%'"
    end

    @products = Product.paginate(options)

    if @products.size == 0  && !params[:category_id] #&& params[:search].chars.length > 3
      category = Category.find(:first, :conditions =>"name LIKE '%#{params[:search]}%'")
      if category
        @categories = []; @categories << category;
        @products = @categories[0].products.paginate(default_options)
      end
    end

  end

  def show
    @product = Product.find(params[:id])
  end

  def get_energy
    @product = Product.find(params[:product_id])
    respond_to do |format|
      format.js if request.xhr?
    end
  end

  def new
    @product = Product.new
    @product.water = 0
    @product.fat = 0
    @product.carbohydrate = 0
    @product.protein = 0
    @product.energy = 0
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

  def default_options
    {
      :order => 'name ASC',
      :per_page => 10,
      :page => params[:page]
    }
  end
end

