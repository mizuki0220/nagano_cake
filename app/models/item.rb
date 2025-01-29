class Item < ApplicationRecord
  belongs_to :genre
  has_many :cart_items, dependent: :destroy

  has_one_attached :image

  #画像が存在しない時のダミー画像表示
  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'no_image.jpg', content_type: 'image/jpg')
    end
    image
  end

  #税込の表示
  def add_tax_price
    (self.price * 1.10).round
  end

  #検索
  def self.search(search)
    return Item.all unless search
    Item.where(['name LIKE ? OR introduction', "%#{search}%"])
  end

end
