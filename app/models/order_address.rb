class OrderAddress
  include ActiveModel::Model
  attr_accessor :post_code, :prefecture_id, :municipalities, :address, :building_name, :phone_number, :user_id, :item_id, :token

  with_options presence: true do
    validates :item_id
    validates :user_id
    validates :post_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/ }
    validates :prefecture_id
    validates :municipalities
    validates :address
    validates :phone_number, numericality: { only_integer: true }
    validates :token, presence: true
  end
  validates :prefecture_id, numericality: { other_than: 1 }
  validates :phone_number, length: { minimum: 10, miximum: 11 }

  def save
    order = Order.create(item_id:, user_id:)

    Address.create(post_code:, prefecture_id:, municipalities:, address:,
                   building_name:, phone_number:, order_id: order.id)
  end
end
