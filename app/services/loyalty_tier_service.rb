class LoyaltyTierService
  def calculate user_id
    user = User.find user_id
    current_tier = user.loyalty_tier
    return if current_tier.is_max_tier

    next_tier = highest_eligible_tier user_id
    user.promote_to_next_loyalty_tier(next_tier) if next_tier.rank > current_tier.rank
  end

  def highest_eligible_tier user_id
    total_spending = total_spending_from_last_year user_id
    LoyaltyTier.ordered_ranking.each do |tier|
      return tier if total_spending >= tier.condition
    end
  end

  def total_spending_from_last_year user_id
    @total_spending_from_last_year ||= Order.completed.where(user_id: user_id).
                                        where(created_at: from_last_year_range).
                                        sum(:total_in_cents)
  end

  def from_last_year_range
    current_year = DateTime.now
    last_year = current_year - 1.year
    last_year.beginning_of_year..current_year.end_of_year
  end
end