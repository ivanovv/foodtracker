require 'test_helper'

class CaloryLinesControllerTest < ActionController::TestCase

  context "logged in user" do
    setup do
      activate_authlogic
      UserSession.create users(:vic)
    end

    should "see index" do
      get :index
      assert_template 'index'
      assert_not_nil assigns(:calory_lines)
      assert_not_nil assigns(:total_calories)
    end

    should "see show" do
      get :show, :id => CaloryLine.first
      assert_template 'show'
      assert_not_nil assigns(:calory_line)
    end

    should "see new calory line" do
      get :new
      assert_template 'new'
      assert_not_nil assigns(:calory_line)
    end

    should "not be able to create invalid calory line" do
      CaloryLine.any_instance.stubs(:valid?).returns(false)
      CaloryLine.any_instance.stubs(:energy).returns(100)
      post :create
      assert_template 'new'
    end

    should "be able to create valid calory line" do
      CaloryLine.any_instance.stubs(:valid?).returns(true)
      CaloryLine.any_instance.stubs(:energy).returns(100)
      post :create
      assert_redirected_to calory_line_url(assigns(:calory_line))
    end

    should "be able to edit calory line" do
      get :edit, :id => CaloryLine.first
      assert_template 'edit'
      assert_not_nil assigns(:calory_line)
      assert_not_nil assigns(:user_days)
    end

    should "not be able to update invalid calory line" do
      CaloryLine.any_instance.stubs(:valid?).returns(false)
      put :update, :id => CaloryLine.first
      assert_template 'edit'
    end

    should "be able to update valid calory line" do
      CaloryLine.any_instance.stubs(:valid?).returns(true)
      put :update, :id => CaloryLine.first
      assert_redirected_to calory_line_url(assigns(:calory_line))
    end

    context "destroy" do

      should "be able to destroy calory line and redirected to calory_lines" do
        calory_line = CaloryLine.first
        delete :destroy, :id => calory_line
        assert_redirected_to calory_lines_url
        assert !CaloryLine.exists?(calory_line.id)
      end

      should "be able to destroy calory line and redirected to day_calory_lines" do
        calory_line = CaloryLine.first
        day = days(:one)
        delete :destroy, :id => calory_line, :day_id => day.to_param
        assert_redirected_to day_calory_lines_url(day)
        assert !CaloryLine.exists?(calory_line.id)
      end

    end
  end
end
