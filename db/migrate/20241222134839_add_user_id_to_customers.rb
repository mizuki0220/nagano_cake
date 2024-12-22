class AddUserIdToCustomers < ActiveRecord::Migration[6.1]
  def change
    add_column :customers, :is_active, :boolean
  end
end
