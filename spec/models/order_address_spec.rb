require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  describe '商品購入機能' do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @order_address = FactoryBot.build(:order_address,user_id: @user.id, item_id: @item.id)
  end
    context '購入できるとき' do
      it 'order_id,post_code,prefecture_id,municipalities,address,phone_number,tokenが存在すれば購入できる' do
        expect(@order_address).to be_valid
      end
      it 'building_nameはなくても購入できる' do
        @order_address.building_name = ''
        expect(@order_address).to be_valid
      end
    end
    context '購入できないとき' do
      it 'post_codeが空では購入できない' do
        @order_address.post_code = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include "Post code can't be blank"
      end
      it 'post_codeが-を含む半角数字3桁と4桁でなければ購入できない' do
        @order_address.post_code = '1112222'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include 'Post code is invalid'
      end
      it 'prefecture_idがなければ購入できない' do
        @order_address.prefecture_id = '1'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include "Prefecture must be other than 1"
      end
      it 'municipalitiesがなければ購入できない' do
        @order_address.municipalities = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include "Municipalities can't be blank"
      end
      it 'addressがなければ購入できない' do
        @order_address.address = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include "Address can't be blank"
      end
      it 'phone_numberがなければ購入できない' do
        @order_address.phone_number = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include "Phone number can't be blank", 'Phone number is not a number',
                                                               'Phone number is too short (minimum is 10 characters)'
      end
      it 'phone_numberが半角数字9桁以下では購入できない' do
        @order_address.phone_number = '012044444'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include 'Phone number is too short (minimum is 10 characters)'
      end
      it 'phone_numberが半角数字12桁以上では購入できない' do
        @order_address.phone_number = '090123456789000'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include 'Phone number is too long (maximum is 11 characters)'
      end
      it 'phone_numberに数字以外が含まれていては購入できない' do
        @order_address.phone_number = 'phonenumber'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include 'Phone number is not a number'
      end
      it 'phone_numberに全角文字が含まれていては購入できない' do
        @order_address.phone_number = '０９０１２３４５６７８'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include 'Phone number is not a number'
      end
      it 'tokenがなければ購入できない' do
        @order_address.token = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include "Token can't be blank"
      end
      it 'itemに紐付いてなければ購入できない' do
        @order_address.item_id = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include "Item can't be blank"
      end
      it 'userに紐付いてなければ購入できない' do
        @order_address.user_id = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include "User can't be blank"
      end
    end
  end
end
