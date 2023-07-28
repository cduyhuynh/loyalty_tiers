require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "list from last year orders" do
    user = users(:gold)
    orders(:completed).user_id = user.id
    orders(:completed).save!

    get api_user_orders_url(user)

    assert_response :success
    response_body = JSON.parse @response.body
    assert_equal(1, response_body.size)

    assert_equal(orders(:completed).id, response_body.first["id"])
  end

  test "list not include orders over 2 years" do
    user = users(:gold)
    orders(:completed).user_id = user.id
    orders(:completed).created_at = DateTime.now - 2.year
    orders(:completed).save!

    get api_user_orders_url(user)

    assert_response :success
    response_body = JSON.parse @response.body
    assert_equal(0, response_body.size)
  end
end
