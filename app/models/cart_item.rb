class CartItem < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :customer
  has_many :items, dependent: :destroy

  def subtotal
    item.with_tax_price * amount
  end
end
