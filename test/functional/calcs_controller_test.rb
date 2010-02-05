require 'test_helper'

class CalcsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => Calc.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    Calc.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    Calc.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to calc_url(assigns(:calc))
  end
  
  def test_edit
    get :edit, :id => Calc.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    Calc.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Calc.first
    assert_template 'edit'
  end
  
  def test_update_valid
    Calc.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Calc.first
    assert_redirected_to calc_url(assigns(:calc))
  end
  
  def test_destroy
    calc = Calc.first
    delete :destroy, :id => calc
    assert_redirected_to calcs_url
    assert !Calc.exists?(calc.id)
  end
end
