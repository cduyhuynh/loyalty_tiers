require "test_helper"

class OrdersControllerTest < ActionDispatch::IntegrationTest
  test "bronze customer completes an order" do
    put api_orders_complete_url, params: { id: orders(:processing).id, customerId: users(:bronze).id, totalInCents: 2000 }

    orders(:processing).reload
    users(:bronze).reload
    assert_response :success
    assert_equal(Order::STATUS[:completed], orders(:processing).status)

    assert_equal(loyalty_tiers(:bronze).id, users(:bronze).loyalty_tier_id)
  end

  test "bronze customer completes an order and reaches silver tier" do
    put api_orders_complete_url, params: { id: orders(:processing).id, customerId: users(:bronze).id, totalInCents: 15000 }

    orders(:processing).reload
    users(:bronze).reload

    assert_response :success
    assert_equal(Order::STATUS[:completed], orders(:processing).status)

    assert_equal(loyalty_tiers(:silver).id, users(:bronze).loyalty_tier_id)
  end

  test "bronze customer completes an order and reaches gold tier" do
    put api_orders_complete_url, params: { id: orders(:processing).id, customerId: users(:bronze).id, totalInCents: 60000 }

    orders(:processing).reload
    users(:bronze).reload

    assert_response :success
    assert_equal(Order::STATUS[:completed], orders(:processing).status)

    assert_equal(loyalty_tiers(:gold).id, users(:bronze).loyalty_tier_id)
  end

  test "gold customer complete an order" do
    put api_orders_complete_url, params: { id: orders(:processing).id, customerId: users(:gold).id, totalInCents: 2000 }

    orders(:processing).reload
    users(:gold).reload
    assert_response :success
    assert_equal(Order::STATUS[:completed], orders(:processing).status)

    assert_equal(loyalty_tiers(:gold).id, users(:gold).loyalty_tier_id)
  end
end
