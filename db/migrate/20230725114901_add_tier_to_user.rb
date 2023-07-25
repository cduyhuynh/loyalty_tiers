class AddTierToUser < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :loyalty_tier, index: true, foreign_key: true
  end
end
