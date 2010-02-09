require 'test_helper'

class CaloryLinesControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => CaloryLine.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    CaloryLine.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    CaloryLine.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to calory_line_url(assigns(:calory_line))
  end
  
  def test_edit
    get :edit, :id => CaloryLine.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    CaloryLine.any_instance.stubs(:valid?).returns(false)
    put :update, :id => CaloryLine.first
    assert_template 'edit'
  end
  
  def test_update_valid
    CaloryLine.any_instance.stubs(:valid?).returns(true)
    put :update, :id => CaloryLine.first
    assert_redirected_to calory_line_url(assigns(:calory_line))
  end
  
  def test_destroy
    calory_line = CaloryLine.first
    delete :destroy, :id => calory_line
    assert_redirected_to calory_lines_url
    assert !CaloryLine.exists?(calory_line.id)
  end
end
