class LoyaltyTier < ApplicationRecord
  has_many :users
  RANKINGS = ['bronze', 'silver', 'gold'].freeze

  def self.next_tier current_tier
    return current_tier if is_max_tier(current_tier)
    self.where(rank: current_tier.rank + 1).first
  end

  def is_max_tier
    self.rank >= RANKINGS.size - 1
  end
end
