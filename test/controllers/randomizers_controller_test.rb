require 'test_helper'

class RandomizersControllerTest < ActionController::TestCase
  setup do
    @randomizer = randomizers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:randomizers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create randomizer" do
    assert_difference('Randomizer.count') do
      post :create, randomizer: {  }
    end

    assert_redirected_to randomizer_path(assigns(:randomizer))
  end

  test "should show randomizer" do
    get :show, id: @randomizer
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @randomizer
    assert_response :success
  end

  test "should update randomizer" do
    patch :update, id: @randomizer, randomizer: {  }
    assert_redirected_to randomizer_path(assigns(:randomizer))
  end

  test "should destroy randomizer" do
    assert_difference('Randomizer.count', -1) do
      delete :destroy, id: @randomizer
    end

    assert_redirected_to randomizers_path
  end
end
