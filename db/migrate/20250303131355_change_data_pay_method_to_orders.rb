class ChangeDataPayMethodToOrders < ActiveRecord::Migration[6.1]
  def change
    change_column :orders, :pay_method, :integer, using: 'pay_method::integer'
  end
end
