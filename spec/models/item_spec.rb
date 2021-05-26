require 'rails_helper'

RSpec.describe Item, type: :model do
  describe "商品出品機能" do
    before do
      @item=FactoryBot.build(:item)
    end
    context "商品の出品ができる時" do
      it "image, name, description, category_id, condtion_id, charge_id, prefecture_id, day_id, priceが存在すれば登録できる" do
        expect(@item).to be_valid
      end
    end
    context "商品の出品ができない時" do
      it "imageが空では登録できない" do
        @item.image=nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it "nameが空では登録できない" do
        @item.name=""
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it "nameが40文字を超えると登録できない" do
        item=FactoryBot.build(:item, name_number: 41)
        item.valid?
        expect(item.errors.full_messages).to include("Name is too long (maximum is 40 characters)")
      end
      it "descriptionが空では登録できない" do
        @item.description=""
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end
      it "descriptionが10000文字を超えては登録できない" do
        item=FactoryBot.build(:item, description_number: 1001)
        item.valid?
        expect(item.errors.full_messages).to include("Description is too long (maximum is 1000 characters)")
      end
      it "category_idが1では登録できない" do
        @item.category_id=1
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end
      it "condition_idが1では登録できない" do
        @item.condition_id=1
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition can't be blank")
      end
      it "charge_idが1では登録できない" do
        @item.charge_id=1
        @item.valid?
        expect(@item.errors.full_messages).to include("Charge can't be blank")
      end
      it "prefecture_idが1では登録できない" do
        @item.prefecture_id=1
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end
      it "day_idが1では登録できない" do
        @item.day_id=1
        @item.valid?
        expect(@item.errors.full_messages).to include("Day can't be blank")
      end
      it "priceが空では登録できない" do
        @item.price=""
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it "priceが300未満では登録できない" do
        @item.price=299
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is out of setting range")
      end
      it "priceが9999999を超えると登録できない" do
        @item.price=10000000
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is out of setting range")
      end
      it "priceが全角文字では登録できない" do
        @item.price="１１１１"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is invalid. Input harf-width characters")
      end
    end
  end
end
