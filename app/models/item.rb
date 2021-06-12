class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  belongs_to :category
  belongs_to :condition
  belongs_to :charge
  belongs_to :prefecture
  belongs_to :day
  has_one_attached :image
  has_one :purchase_log

  with_options presence: true do
    validates :image
    validates :name, length: { maximum: 40 }
    validates :description, length: { maximum: 1000 }
    validates :category_id, :condition_id, :charge_id, :prefecture_id, :day_id,
              numericality: { other_than: 1, message: "can't be blank" }
    validates :price, numericality: { only_integer: true, message: 'is invalid. Input harf-width characters' }
    validates :price,
              numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999,
                              message: 'is out of setting range' }
  end
end
