class OrdersService
  def complete order, params
    order.user_id = params[:customerId]
    order.total_in_cents = params[:totalInCents]
    order.status = Order::STATUS[:completed]
    order.save!
    order.reload

    loyalty_tier_service = LoyaltyTierService.new
    loyalty_tier_service.calculate params[:customerId]
  end

  def list_by user
    Order.where(user_id: user.id).
      where(created_at: current_cycle_range).
      select(:id, "total_in_cents::decimal/100 as total", "DATE_PART('EPOCH', created_at) as created_timestamp")
  end

  private
  def current_cycle_range
    now = DateTime.now
    last_year = now - 1.year
    last_year.beginning_of_year..now
  end
end