class CartItem < ApplicationRecord
  belongs_to :customer
  belongs_to :item

  def subtotal
    item.with_tax_price * amount
  end

  # カート内商品の合計金額を計算する
  def self.total_price(cart_items)
    cart_items.sum { |cart_item| cart_item.subtotal }
  end
end
