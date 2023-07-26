class Order < ApplicationRecord
  belongs_to :user
  # has_many :order_items
  STATUS = {initial: "INITIAL", processing: "PROCESSING", completed: "COMPLETED"}

  validates :total_in_cents, presence: true, comparison: { greater_than: 0 }
  validates :status, presence: true, inclusion: { in: STATUS.values }

  scope :completed, -> { where(status: STATUS[:completed]) }
end
