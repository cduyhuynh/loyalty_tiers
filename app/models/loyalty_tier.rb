class LoyaltyTier < ApplicationRecord
  has_many :users
  RANKINGS = ['bronze', 'silver', 'gold'].freeze

  scope :ordered_ranking, -> { order(rank: :desc) }

  def is_max_tier
    rank >= RANKINGS.size
  end

  def self.next_tier current_tier
    return nil if current_tier.is_max_tier
    find_by_rank(current_tier.rank + 1)
  end

  def self.default_tier
    order(:rank).first
  end
end
