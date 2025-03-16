class Genre < ApplicationRecord
  has_many :items, dependent: :destroy

  # **1. フォームを空で保存したくない**
  validates :name, presence: true

  # **2. 文字のみ許可（ジャンル名）**
  validates :name, format: { with: /\A[ぁ-んァ-ン一-龥a-zA-Z]+\z/, message: "は文字のみ入力できます" }

  # **3. 一意性（同じジャンル名を登録できない）**
  validates :name, uniqueness: { case_sensitive: false, message: "は既に存在します" }

end
