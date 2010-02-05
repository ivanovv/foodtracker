require 'test_helper'

class FoodsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => Food.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    Food.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    Food.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to food_url(assigns(:food))
  end
  
  def test_edit
    get :edit, :id => Food.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    Food.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Food.first
    assert_template 'edit'
  end
  
  def test_update_valid
    Food.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Food.first
    assert_redirected_to food_url(assigns(:food))
  end
  
  def test_destroy
    food = Food.first
    delete :destroy, :id => food
    assert_redirected_to foods_url
    assert !Food.exists?(food.id)
  end
end
