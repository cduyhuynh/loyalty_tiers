class CreateLoyaltyTiers < ActiveRecord::Migration[7.0]
  def change
    create_table :loyalty_tiers do |t|
      t.string :name
      t.integer :condition
      t.integer :rank
      t.timestamps
    end
  end
end
