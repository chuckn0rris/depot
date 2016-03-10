require 'test_helper'

class CartsControllerTest < ActionController::TestCase
  setup do
    @cart = carts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:carts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cart" do
    assert_difference('Cart.count') do
      post :create, cart: {  }
    end

    assert_redirected_to cart_path(assigns(:cart))
  end

  test "should show cart" do
    get :show, id: @cart
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cart
    assert_response :success
  end

  test "should update cart" do
    patch :update, id: @cart, cart: {  }
    assert_redirected_to cart_path(assigns(:cart))
  end

  test "should destroy cart" do
    assert_difference('Cart.count', -1) do
      session[:cart_id]  =@cart.id
      delete :destroy, id: @cart
    end
    assert_redirected_to store_url
  end

  test "should add different items to different positions" do
    @cart.add_product products(:ruby).id, products(:ruby).price
    @cart.add_product products(:one).id, products(:one).price

    assert Cart.find(@cart.id).line_items.count, 2
  end

  test "should add two items into one position" do
    @cart.add_product products(:ruby).id, products(:ruby).price
    @cart.add_product products(:ruby).id, products(:ruby).price

    assert Cart.find(@cart.id).line_items.count, 1
  end

  test "should be price like at product" do
    @cart.add_product products(:ruby).id, products(:ruby).price

    assert Cart.find(@cart.id).line_items.count, 1
    Cart.find(@cart.id).line_items do |item|
      assert_equal item.price, products(:ruby).price
    end
  end
end
