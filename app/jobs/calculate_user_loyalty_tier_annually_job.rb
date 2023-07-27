class CalculateUserLoyaltyTierAnnuallyJob < ApplicationJob
  queue_as :default

  def perform(*args)
    service = LoyaltyTierByBatchService.new
    User.find_in_batches(batch_size: 5000) do |users|
      service.calculate users
    end
  end
end
