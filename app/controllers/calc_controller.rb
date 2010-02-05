class CalcController < ApplicationController
  def index
    @calcs = []
    @calcs << Calc.new
  end
  
  def edit
    @calc = Calc.new
  end
    
  def new
    @calc = Calc.new
    puts session[:weight]
    @calc.weight = session[:weight] if session[:weight]
  end
  
  def update
    weight = params[:calc][:weight].to_f
    puts weight
    user = current_user
    if user.female
      @base_metabolic_norm = (10 * weight) + (6.25 * user.height) - (5 * user.age) - 161        
    else
      @base_metabolic_norm = (10 * weight) + (6.25 * user.height) - (5 * user.age) + 5
    end
    flash[:notice] = "OMH equals #{@base_metabolic_norm}."
    session[:weight] = weight
    puts session[:weight]
    redirect_to :back
  end
  
end
