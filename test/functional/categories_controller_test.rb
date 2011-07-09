require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
  context "logged in user" do
    setup do
      activate_authlogic
      UserSession.create users(:vic)
    end

    should "see index" do
      get :index
      assert_template 'index'
    end

    should "see show" do
      get :show, :id => Category.first
      assert_template 'show'
    end

    should "see new" do
      get :new
      assert_template 'new'
    end

    should "not create invalid category" do
      Category.any_instance.stubs(:valid?).returns(false)
      Category.any_instance.stubs(:errors).returns({:yes => "error"})
      post :create
      respond_with :success
      assert_template 'new'
    end

    should "create valid" do
      Category.any_instance.stubs(:valid?).returns(true)
      post :create
      redirect_to category_url(assigns(:category))
    end

    should "edit" do
      get :edit, :id => Category.first
      assert_template 'edit'
    end

    should "not update invalid category" do
      Category.any_instance.stubs(:valid?).returns(false)
      put :update, :id => Category.first
      assert_template 'edit'
    end

    should " update valid category" do
      Category.any_instance.stubs(:valid?).returns(true)
      put :update, :id => Category.first
      assert_redirected_to category_url(assigns(:category))
    end

    should "destroy" do
      category = Category.first
      delete :destroy, :id => category
      assert_redirected_to categories_url
      assert !Category.exists?(category.id)
    end
  end
end

