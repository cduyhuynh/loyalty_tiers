class User < ApplicationRecord
  has_many :orders

  validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
end
