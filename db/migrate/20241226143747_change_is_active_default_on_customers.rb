class ChangeIsActiveDefaultOnCustomers < ActiveRecord::Migration[6.1]
  def change
    change_column_default :customers, :is_active, from: false, to: true
  end
end
