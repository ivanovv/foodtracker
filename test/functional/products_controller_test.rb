require 'test_helper'

class ProductsControllerTest < ActionController::TestCase

  context "any user" do

    should "index" do
      get :index
      assert_template 'index'
    end
    
    should "show" do
      get :show, :id => Product.first
      assert_template 'show'
    end
    
    should "new" do
      get :new
      assert_template 'new'
    end
    
    should "not create invalid" do
      Product.any_instance.stubs(:valid?).returns(false)
      post :create
      assert_template 'new'
    end
  
    should "create valid" do
      Product.any_instance.stubs(:valid?).returns(true)
      post :create
      assert_redirected_to product_url(assigns(:product))
    end

  end

  context "not logged in user" do

    should "edit" do
      get :edit, :id => Product.first
      assert_redirected_to login_url
    end
  
    should "not update invalid" do
      Product.any_instance.stubs(:valid?).returns(false)
      put :update, :id => Product.first
      assert_redirected_to login_url
    end
  
    should "update valid" do
      Product.any_instance.stubs(:valid?).returns(true)
      put :update, :id => Product.first
      assert_redirected_to login_url
    end
  
    should "destroy" do
      product = Product.first
      delete :destroy, :id => product
      assert_redirected_to login_url
    end
  end

  context "logged in user" do
    setup do
      activate_authlogic
      UserSession.create users(:vic)
    end

    should "edit" do
      get :edit, :id => Product.first
      assert_template 'edit'
    end

    should "not update invalid" do
      Product.any_instance.stubs(:valid?).returns(false)
      put :update, :id => Product.first
      assert_template 'edit'
    end

    should "update valid" do
      Product.any_instance.stubs(:valid?).returns(true)
      put :update, :id => Product.first
      assert_redirected_to product_url(assigns(:product))
    end

    should "destroy" do
      product = Product.first
      delete :destroy, :id => product
      assert_redirected_to products_url
      assert !Product.exists?(product.id)
    end

  end

end
