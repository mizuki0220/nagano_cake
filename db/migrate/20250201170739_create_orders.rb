class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer "customer_id", null: false
      t.string "name", null: false
      t.string "postal_code", null: false
      t.text "address", null: false
      t.integer "shipping_fee", null: false
      t.integer "total_price", null: false
      t.string "pay_method", null: false
      t.boolean "is_active", default: true
      
      t.timestamps
    end
  end
end
