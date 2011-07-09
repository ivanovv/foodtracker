require 'test_helper'

class DaysControllerTest < ActionController::TestCase

  context "logged in user" do
    setup do
      activate_authlogic
      UserSession.create users(:vic)
    end

    should "index" do
      get :index
      assert_template 'index'
    end

    should "show" do
      get :show, :id => Day.first.to_param
      assert_template 'show'
    end

    should "new" do
      get :new
      assert_template 'new'
    end

    should "not create invalid day" do
      Day.any_instance.stubs(:valid?).returns(false)
      Day.any_instance.stubs(:errors).returns({:yes => "error"})
      post :create, :id => '2010-01-01'
      assert_template 'new'
    end

    should "create_valid" do
      Day.any_instance.stubs(:valid?).returns(true)
      Day.any_instance.stubs(:to_param).returns("2010-01-01")
      post :create, :id => '2010-01-01'
      assert_redirected_to day_url(assigns(:day))
    end

    should "edit" do
      get :edit, :id => Day.first.to_param
      assert_template 'edit'
    end

    should "not update invalid day" do
      Day.any_instance.stubs(:valid?).returns(false)
      Day.any_instance.stubs(:errors).returns({:yes => "error"})
      put :update, :id => Day.first.to_param
      assert_template 'edit'
    end

    should "update valid day" do
      Day.any_instance.stubs(:valid?).returns(true)
      put :update, :id => Day.first.to_param
      redirect_to day_url(assigns(:day))
    end

    should "destroy day" do
      day = Day.first
      delete :destroy, :id => day.to_param
      assert_redirected_to days_url
      assert !Day.exists?(day.id)
    end

  end

end

