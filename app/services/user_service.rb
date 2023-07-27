class UserService
  def initialize user
    @user = user
  end

  def show
    serialized_user = {}
    serialized_user[:loyalty_tier] = @user.loyalty_tier.name
    serialized_user[:tier_calculation_start_date] = tier_calculation_start_date
    serialized_user[:total_spending] = current_cycle_total_spending
    serialized_user[:next_tier_remaining_amount] = next_tier_remaining_amount
    serialized_user[:downgraded_tier] = downgraded_tier
    serialized_user[:downgraded_date] = downgraded_date
    serialized_user[:to_be_maintained_tier_remaining] = to_be_maintained_tier_remaining
    serialized_user
  end

  def tier_calculation_start_date
    last_year = Date.current - 1.year
    last_year.beginning_of_year
  end

  def tier_calculation_cycle
    current_year = DateTime.now
    last_year = current_year - 1.year
    last_year.beginning_of_year..current_year.end_of_year
  end

  def current_cycle_total_spending
    @current_cycle_total_spending ||= Order.completed.where(user_id: @user.id).
                                          where(created_at: tier_calculation_cycle).
                                          sum(:total_in_cents)
  end

  def next_tier_remaining_amount
    next_tier = LoyaltyTier.next_tier @user.loyalty_tier
    return 0 if next_tier.nil?

    (next_tier.condition - current_cycle_total_spending).abs
  end

  def lowest_eligible_tier
    LoyaltyTier.ordered_ranking.each do |tier|
      return tier if current_cycle_total_spending >= tier.condition
    end
  end

  def downgraded_tier
    eligible_tier = lowest_eligible_tier
    current_tier = @user.loyalty_tier
    eligible_tier.rank < current_tier.rank ? eligible_tier.name : nil
  end

  def downgraded_date
    return nil if downgraded_tier.nil?
    Date.current.end_of_year
  end

  def to_be_maintained_tier_remaining
    current_tier = @user.loyalty_tier

    current_cycle_total_spending >= current_tier.condition ? 0 : current_tier.condition - current_cycle_total_spending
  end
end