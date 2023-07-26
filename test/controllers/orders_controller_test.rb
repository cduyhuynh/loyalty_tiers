require "test_helper"

class OrdersControllerTest < ActionDispatch::IntegrationTest
  test "complete an order" do
    put api_orders_complete_url, params: { id: orders(:processing).id, customerId: users(:one).id, totalInCents: 2000 }

    orders(:processing).reload
    assert_response :success
    assert_equal(Order::STATUS[:completed], orders(:processing).status)
  end
end
