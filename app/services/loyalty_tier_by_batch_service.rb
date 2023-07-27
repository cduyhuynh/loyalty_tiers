class LoyaltyTierByBatchService
  def calculate users
    to_be_updated_users = []
    total_spendings = total_spending_in_last_year_by_users users

    users.each do |user|
      current_tier = user.loyalty_tier

      if total_spendings[user.id].nil?
        to_be_updated_users << {id: user.id, loyalty_tier_id: LoyaltyTier.default_tier.id}
        next
      end

      next_tier = eligible_tier user.id, total_spendings[user.id]
      to_be_updated_users << {id: user.id, loyalty_tier_id: next_tier.id} if next_tier.rank > current_tier.rank
    end
    User.upsert_all(to_be_updated_users) if to_be_updated_users.present?
  end

  def eligible_tier user_id, total_spending
    LoyaltyTier.ordered_ranking.each do |tier|
      return tier if total_spending >= tier.condition
    end
  end

  def total_spending_in_last_year_by_users users
    user_ids = users.map &:id
    Order.completed.where(user_id: user_ids).
      where(created_at: last_year_range).
      group(:user_id).
      sum(:total_in_cents)
  end

  def last_year_range
    last_year = DateTime.now - 1.year
    last_year.beginning_of_year..last_year.end_of_year
  end
end