class UsersController < ApplicationController
  respond_to :html

  def new
    respond_with(@user = User.new)
  end

  def create
    @user = User.new(params[:user])
    flash[:notice] = t(:success_reg) if @user.save
    respond_with(@user)
  end

  def edit
    @user = current_user
    respond_with(@user)
  end

  def update
    @user = current_user
    flash[:notice] = t(:success_profile_update) if @user.update_attributes(params[:user])
    respond_with(@user)
  end
end

