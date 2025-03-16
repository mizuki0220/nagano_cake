class Address < ApplicationRecord
  belongs_to :customer

  # **1. フォームを空で保存したくない**
  validates :name, :postal_code, :address, presence: true

  # **2. 文字のみ許可（宛名）**
  validates :name, format: { with: /\A[ぁ-んァ-ン一-龥々ー]+\z/, message: "は文字のみ入力できます" }

  # **3. 郵便番号のフォーマット（7桁の数字）**
  validates :postal_code, format: { with: /\A\d{7}\z/, message: "は半角数字7桁で入力してください" }

  def address_display
    '〒' + postal_code + ' ' + address + ' ' + name
  end

end
