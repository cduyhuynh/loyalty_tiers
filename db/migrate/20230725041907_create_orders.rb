class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.references :user
      t.integer :total_in_cents
      t.string :status
      t.timestamps
    end
  end
end
