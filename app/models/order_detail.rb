class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item

  enum is_active: { "着手不可": 0, "製作待ち": 1, "製作中": 2, "製作完了": 3 }

  after_update :update_order_status

  private

  def update_order_status
    if order.order_details.where.not(is_active: "製作完了").exists?
      order.update(is_active: "製作中") if order.is_active != "製作中"
    else
      order.update(is_active: "発送準備中")
    end
  end
end
