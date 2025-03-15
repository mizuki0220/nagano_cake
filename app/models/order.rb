class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details, dependent: :destroy
  has_many :items, through: :order_details

  enum payment_method: { credit_card: 0, transfer: 1 }
  enum is_active: { "入金待ち": 0, "入金確認": 1, "製作中": 2, "発送準備中": 3, "発送済": 4 }

  after_update :update_order_details_status

  private

  def update_order_details_status
    if is_active_before_last_save == "入金待ち" && is_active == "入金確認"
      order_details.update_all(is_active: "製作待ち")
    end
  end
end
