class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item

  enum is_active: {
    "着手不可":0, "製作待ち":1, "製作中":2, "製作完了":3
  }
end
