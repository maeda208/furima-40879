require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
    
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it 'nicknameとemail、passwordとpassword_confirmationが存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end
    context '新規登録できないとき' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Nickname can't be blank"
      end
      it 'emaliが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Email can't be blank"
      end
      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'emailは@を含まないと登録できない' do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password = '00000'
        @user.password_confirmation = '00000'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'passwordは半角英字のみでは登録できない' do
        @user.password = 'abcdef'
        @user.password_confirmation = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password must include both letters and numbers')
      end
      it 'passwordは半角数字のみでは登録できない' do
        @user.password = '19910208'
        @user.password_confirmation = '19910208'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password must include both letters and numbers')
      end
      it 'passwordは全角では登録できない' do
        @user.password = '六月'
        @user.password_confirmation = '六月'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password must include both letters and numbers')
      end
      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '1234567'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it '苗字が空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
      it '苗字は全角の漢字・ひらがな・カタカナでなければ登録できない' do
        @user.last_name = 'r6'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name is invalid')
      end
      it '名前が空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it '名前は全角の漢字・ひらがな・カタカナでなければ登録できない' do
        @user.first_name = 'r6'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name is invalid')
      end
      it '苗字カナが空では登録できない' do
        @user.read_last = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Read last can't be blank")
      end
      it '苗字カナは全角のカタカナでなければ登録できない' do
        @user.read_last = 'r六'
        @user.valid?
        expect(@user.errors.full_messages).to include('Read last is invalid')
      end
      it '名前カナが空では登録できない' do
        @user.read_first = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Read first can't be blank")
      end
      it '名前カナは全角のカタカナでなければ登録できない' do
        @user.read_first = 'r六'
        @user.valid?
        expect(@user.errors.full_messages).to include('Read first is invalid')
      end
      it '誕生日が空では登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end
