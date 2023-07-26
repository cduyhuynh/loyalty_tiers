class User < ApplicationRecord
  has_many :orders
  belongs_to :loyalty_tier
  before_validation :set_default_tier

  validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  def promote_to_next_loyalty_tier next_tier
    self.loyalty_tier_id = next_tier.id
    self.save!
  end

  private
  def set_default_tier
    self.loyalty_tier = LoyaltyTier.default_tier
  end
end
