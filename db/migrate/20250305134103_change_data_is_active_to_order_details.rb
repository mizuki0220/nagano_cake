class ChangeDataIsActiveToOrderDetails < ActiveRecord::Migration[6.1]
  def change
    change_column :order_details, :is_active, :integer, using: 'is_active::integer'
  end
end
