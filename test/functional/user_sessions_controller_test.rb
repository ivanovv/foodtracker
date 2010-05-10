require 'test_helper'

class UserSessionsControllerTest < ActionController::TestCase
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    UserSession.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    UserSession.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to root_url
  end

  context "logged in user" do
    setup do
      activate_authlogic
      UserSession.create users(:vic)
    end
  
    should "destroy" do
      user_session = UserSession.find
      delete :destroy, :id => user_session
      assert_redirected_to root_url
      assert !UserSession.find
    end
  end

end
