class LoyaltyTierService
  def calculate user_id
    user = User.find user_id
    current_tier = user.loyalty_tier
    return if current_tier.is_max_tier

    next_tier = LoyaltyTier.next_tier current_tier
    user.promote_to_next_tier(next_tier) if total_spending_from_last_year >= next_tier.condition
  end

  def total_spending_from_last_year user_id
    Order.completed.where(user_id: user_id).
      where(created_at: from_last_year_range).
      sum(:total_in_cents)
  end

  def from_last_year_range
    current_year = DateTime.now
    last_year = current_year - 1.year
    last_year.beginning_of_year..current_year.end_of_year
  end
end