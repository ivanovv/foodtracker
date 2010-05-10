require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  
  fixtures :users

  context "logged in user" do
    setup do
      activate_authlogic
      UserSession.create users(:vic)
    end

    def test_edit
      get :edit, :id => User.first
      assert_template 'edit'
    end

    def test_update_invalid
      User.any_instance.stubs(:valid?).returns(false)
      put :update, :id => User.first
      assert_template 'edit'
    end

    def test_update_valid
      User.any_instance.stubs(:valid?).returns(true)
      put :update, :id => User.first
      assert_redirected_to user_url(assigns(:user))
    end

    def test_destroy
      user = User.first
      delete :destroy, :id => user
      assert_redirected_to users_url
      assert !User.exists?(user.id)
    end


  end

  context "not logged in user" do

    def test_new
      get :new
      assert_template 'new'
    end
  
    def test_create_invalid
      User.any_instance.stubs(:valid?).returns(false)
      post :create
      assert_template 'new'
    end
  
    def test_create_valid
      User.any_instance.stubs(:valid?).returns(true)
      post :create
      assert_redirected_to user_url(assigns(:user))
    end
  
    def test_edit
      get :edit, :id => User.first
      assert_redirected_to login_url
    end
  
    def test_update_invalid
      User.any_instance.stubs(:valid?).returns(false)
      put :update, :id => User.first
      assert_redirected_to login_url
    end
  
    def test_update_valid
      User.any_instance.stubs(:valid?).returns(true)
      put :update, :id => User.first
      assert_redirected_to login_url
    end
  
    def test_destroy
      user = User.first
      delete :destroy, :id => user      
      assert_redirected_to login_url
    end
  end
end
