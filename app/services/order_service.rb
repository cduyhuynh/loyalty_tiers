class OrderService
  def complete order, params
    order.user_id = params[:customerId]
    order.total_in_cents = params[:totalInCents]
    order.status = Order::STATUS[:completed]
    order.save!
    order.reload

    loyalty_tier_service = LoyaltyTierService.new
    loyalty_tier_service.calculate params[:customerId]
  end
end