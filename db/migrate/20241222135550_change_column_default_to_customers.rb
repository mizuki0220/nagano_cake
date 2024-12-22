class ChangeColumnDefaultToCustomers < ActiveRecord::Migration[6.1]
  def change
    change_column_default :customers, :is_active, from: nil, to: "false"
  end
end
