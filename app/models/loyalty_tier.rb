class LoyaltyTier < ApplicationRecord
  has_many :users
  RANKINGS = ['bronze', 'silver', 'gold'].freeze

  scope :ordered_ranking, -> { order(rank: :desc) }

  def is_max_tier
    rank >= RANKINGS.size
  end

  def self.default_tier
    order(:rank).first
  end
end
