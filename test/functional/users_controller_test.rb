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
  end

  context "not logged in user" do

    def test_new
      get :new
      assert_template 'new'
    end

    def test_create_invalid
      User.any_instance.stubs(:valid?).returns(false)
      User.any_instance.stubs(:errors).returns({:yes => "error"})
      post :create
      assert_template 'new'
    end

    def test_create_valid
      User.any_instance.stubs(:valid?).returns(true)
      User.any_instance.stubs(:save).returns(true)
      post :create, {:user => {
        :username => "test",
        :email => "vic@gmail.com",
        :crypted_password => "cp",
        :password_salt =>"password_salt",
        :persistence_token => "persistence_token",
        :single_access_token => "users.single_access_token"
        }
      }
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

  end
end

