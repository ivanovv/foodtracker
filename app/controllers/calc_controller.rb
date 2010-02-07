class CalcController < ApplicationController
  def index
    @calc = Calc.new
    @calc.weight = session[:weight] if session[:weight]
  end
  
  def edit
    @calc = Calc.new
  end
    
  def new
    @calc = Calc.new
    @calc.weight = session[:weight] if session[:weight]
  end
  
  def update
    @calc = Calc.new
    @calc.weight = params[:calc][:weight]
    if @calc.valid?
      weight = params[:calc][:weight].to_f
      user = current_user
      @base_metabolic_norm = user.base_metabolic_rate(weight)
      flash[:notice] = "OMH equals #{@base_metabolic_norm} kcal."
      session[:weight] = weight
      redirect_to :back
    else
      render :action => "index"
    end
  end  
end
