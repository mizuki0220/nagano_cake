class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details, dependent: :destroy
  has_many :items, through: :order_details

  # **1. フォームを空で保存したくない**
  validates :name, :postal_code, :address, :shipping_fee, :total_price, :payment_method, presence: true, unless: :using_customer_address?

  # **2. 数値のみ許可（送料・合計金額・支払い方法）**
  validates :shipping_fee, :total_price, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :payment_method, numericality: { only_integer: true }

  # **3. 文字のみ許可（氏名）**
  validates :name, format: { with: /\A[ぁ-んァ-ン一-龥々ー]+\z/, message: "は文字のみ入力できます" }

  # **4. 郵便番号のフォーマット（7桁の数字）**
  validates :postal_code, format: { with: /\A\d{7}\z/, message: "は半角数字7桁で入力してください" }, allow_blank: true

  enum payment_method: { credit_card: 0, transfer: 1 }
  enum is_active: { "入金待ち": 0, "入金確認": 1, "製作中": 2, "発送準備中": 3, "発送済": 4 }

  after_update :update_order_details_status

  private

  def update_order_details_status
    if is_active_before_last_save == "入金待ち" && is_active == "入金確認"
      order_details.update_all(is_active: "製作待ち")
    end
  end

  def using_customer_address?
    self.customer_id.present? && self.postal_code.blank? && self.address.blank?
  end
end
