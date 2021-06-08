class PurchaseLogAddress
  include ActiveModel::Model

  attr_accessor :token, :user_id, :item_id, :postal_code, :prefecture_id, :municipality, :house_number, :building_name,
                :phone_number

  with_options presence: true do
    validates :token, :user_id, :item_id, :municipality, :house_number
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Enter it as follows (e.g. 123-4567)' }
    validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :phone_number, format: { with: /\A[0-9]+\z/, message: 'is invalid. Input only number' }
    validates :phone_number, length: { minimum: 10, message: 'is too short' }
    validates :phone_number, length: { maximum: 11, message: 'is too long' }
  end

  def save
    purchase_log = PurchaseLog.create(item_id: item_id, user_id: user_id)
    Address.create(postal_code: postal_code, prefecture_id: prefecture_id, municipality: municipality,
                   house_number: house_number, building_name: building_name, phone_number: phone_number, purchase_log_id: purchase_log.id)
  end
end
