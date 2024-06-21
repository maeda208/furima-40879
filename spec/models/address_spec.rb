require 'rails_helper'

RSpec.describe Address, type: :model do
  before do
    @address = FactoryBot.build(:address)
  end
  describe '商品購入機能' do
    context '購入できるとき' do
      it 'order_id,post_code,prefecture_id,municipalities,address,phone_number,tokenが存在すれば購入できる' do
        expect(@address).to be_valid
      end
      it 'building_nameはなくても購入できる' do
        @address.building_name = ''
        expect(@address).to be_valid
      end
    end
  end
end
