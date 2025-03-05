class ChangeDataIsActiveToOrders < ActiveRecord::Migration[6.1]
  def change
    change_column :orders, :is_active, :integer, using: 'is_active::integer'
  end
end
