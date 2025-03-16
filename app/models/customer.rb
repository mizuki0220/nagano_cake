class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :cart_items, dependent: :destroy
  has_many :addresses, dependent: :destroy
  has_many :orders, dependent: :destroy


  # **1. フォームを空で保存したくない（必須入力）**
  validates :last_name, :first_name, :email, :postal_code, :address, :telephone_number, presence: true

  # **2. 数値のみ許可（郵便番号・電話番号）**
  validates :postal_code, format: { with: /\A\d{7}\z/, message: "は半角数字7桁で入力してください" }
  validates :telephone_number, format: { with: /\A\d+\z/, message: "は半角数字のみで入力してください" }

  # **3. 文字のみ許可（氏名）**
  validates :last_name, :first_name, format: { with: /\A[ぁ-んァ-ン一-龥々ー]+\z/, message: "は文字のみ入力できます" }

end
