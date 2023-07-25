class User < ApplicationRecord
  has_many :orders
  belongs_to :loyalty_tier

  validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
end
