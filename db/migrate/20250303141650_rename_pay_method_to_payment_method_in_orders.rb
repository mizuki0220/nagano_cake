class RenamePayMethodToPaymentMethodInOrders < ActiveRecord::Migration[6.1]
  def change
    rename_column :orders, :pay_method, :payment_method
  end
end
