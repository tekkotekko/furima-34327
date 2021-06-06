require 'rails_helper'

RSpec.describe PurchaseLogAddress, type: :model do
  describe '商品購入情報の保存' do
    before do
      @user = FactoryBot.create(:user)
      @item = FactoryBot.create(:item)
      @purchase_log_address = FactoryBot.build(:purchase_log_address, user_id: @user.id, item_id: @item.id)
      sleep(0.1)
    end

    context '内容に問題がない場合' do
      it '全ての情報が正しく入力されていれば保存できること' do
        expect(@purchase_log_address).to be_valid
      end
      it 'building_nameは空でも保存できること' do
        @purchase_log_address.building_name = ''
        expect(@purchase_log_address).to be_valid
      end
    end
    context '内容に問題がある場合' do
      it 'tokenが空では保存できないこと' do
        @purchase_log_address.token = ''
        @purchase_log_address.valid?
        expect(@purchase_log_address.errors.full_messages).to include("Token can't be blank")
      end
      it 'postal_codeが空では保存できないこと' do
        @purchase_log_address.postal_code = ''
        @purchase_log_address.valid?
        expect(@purchase_log_address.errors.full_messages).to include("Postal code can't be blank")
      end
      it 'postal_codeが半角ハイフンを含んでいないと保存できないこと' do
        @purchase_log_address.postal_code = '1234567'
        @purchase_log_address.valid?
        expect(@purchase_log_address.errors.full_messages).to include('Postal code is invalid. Enter it as follows (e.g. 123-4567)')
      end
      it 'postal_codeの前半の桁数が異なると保存できないこと' do
        @purchase_log_address.postal_code = '1234-5678'
        @purchase_log_address.valid?
        expect(@purchase_log_address.errors.full_messages).to include('Postal code is invalid. Enter it as follows (e.g. 123-4567)')
      end
      it 'postal_codeの後半の桁数が異なると保存できないこと' do
        @purchase_log_address.postal_code = '123-567'
        @purchase_log_address.valid?
        expect(@purchase_log_address.errors.full_messages).to include('Postal code is invalid. Enter it as follows (e.g. 123-4567)')
      end
      it 'prefecture_idが1では保存できないこと' do
        @purchase_log_address.prefecture_id = 1
        @purchase_log_address.valid?
        expect(@purchase_log_address.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'municipalityが空では保存できないこと' do
        @purchase_log_address.municipality = ''
        @purchase_log_address.valid?
        expect(@purchase_log_address.errors.full_messages).to include("Municipality can't be blank")
      end
      it 'house_numberが空では保存できないこと' do
        @purchase_log_address.house_number = ''
        @purchase_log_address.valid?
        expect(@purchase_log_address.errors.full_messages).to include("House number can't be blank")
      end
      it 'phone_numberが空では保存できないこと' do
        @purchase_log_address.phone_number = ''
        @purchase_log_address.valid?
        expect(@purchase_log_address.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'phone_numberが全角数字では保存できないこと' do
        @purchase_log_address.phone_number = '１２３４５６７８９０１'
        @purchase_log_address.valid?
        expect(@purchase_log_address.errors.full_messages).to include('Phone number is invalid. Input only number')
      end
      it 'phone_numberが半角英字では保存できないこと' do
        @purchase_log_address.phone_number = 'aaaaaaaaaaa'
        @purchase_log_address.valid?
        expect(@purchase_log_address.errors.full_messages).to include('Phone number is invalid. Input only number')
      end
      it 'phone_numberが全角英字では保存できないこと' do
        @purchase_log_address.phone_number = 'ａａａａａａａａａａａ'
        @purchase_log_address.valid?
        expect(@purchase_log_address.errors.full_messages).to include('Phone number is invalid. Input only number')
      end
      it 'phone_numberにハイフンが含まれると保存できないこと' do
        @purchase_log_address.phone_number = '123-4567890'
        @purchase_log_address.valid?
        expect(@purchase_log_address.errors.full_messages).to include('Phone number is invalid. Input only number')
      end
      it 'phone_numberが10桁未満だと保存できないこと' do
        @purchase_log_address = FactoryBot.build(:purchase_log_address, user_id: @user.id, item_id: @item.id, digitpn: 9)
        @purchase_log_address.valid?
        expect(@purchase_log_address.errors.full_messages).to include('Phone number is too short')
      end
      it 'phone_numberが11桁を超えると保存できないこと' do
        @purchase_log_address = FactoryBot.build(:purchase_log_address, user_id: @user.id, item_id: @item.id, digitpn: 12)
        @purchase_log_address.valid?
        expect(@purchase_log_address.errors.full_messages).to include('Phone number is too long')
      end
      it '購入者の情報が紐ついていないと保存できないこと' do
        @purchase_log_address.user_id = ''
        @purchase_log_address.valid?
        expect(@purchase_log_address.errors.full_messages).to include("User can't be blank")
      end
      it '購入商品の情報が紐づいていないと保存できないこと' do
        @purchase_log_address.item_id = ''
        @purchase_log_address.valid?
        expect(@purchase_log_address.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
