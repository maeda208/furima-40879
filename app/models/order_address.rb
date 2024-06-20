class OrderAddress
  include ActiveModel::Model
  attr_accessor :post_code, :prefecture_id, :municipalities, :address, :building_name, :phone_number, :user_id, :item_id, :token

  with_options presence: true do
    validates :item_id
    validates :user_id
    validates :post_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/ }
    validates :prefecture_id, numericality: { other_than: 1 }
    validates :municipalities
    validates :address
    validates :phone_number, numericality: { only_integer: true }, length: { minimum: 10, miximum: 11 }
    validates :token
  end

  def save
    order = Order.create(item_id:item.id, user_id:user.id)

    Address.create(post_code:post_code, prefecture_id:prefecture_id, municipalities:municipalities, address:address,
                   building_name:building_name, phone_number:phone_number, order_id:order.id)
  end
end
