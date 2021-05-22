require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user=FactoryBot.build(:user)
  end

  describe "user新規登録" do
    context "新規登録できる時" do
      it "nickname, email, password, password_confirmation, last_name, first_name, last_name_kana, first_name_kana, birth_dateが存在すれば登録できる" do
        expect(@user).to be_valid
      end
      it "emailに@が含まれていれば登録できる" do
        @user.email="test@test"
        expect(@user).to be_valid
      end
      it "passwordが6文字以上であれば登録できる" do
        @user.password="111aaa"
        @user.password_confirmation="111aaa"
        expect(@user).to be_valid
      end
      it "passwordに半角英数字の両方が含まれていれば登録できる" do
        @user.password="aaaaaa111111"
        @user.password_confirmation="aaaaaa111111"
        expect(@user).to be_valid
      end
      it "last_nameとfirst_nameが全角漢字であれば登録できる" do
        @user.last_name="阿阿阿"
        @user.first_name="阿阿阿"
        expect(@user).to be_valid
      end
      it "last_nameとfirst_nameが全角カタカナであれば登録できる" do
        @user.last_name="アアア"
        @user.first_name="アアア"
        expect(@user).to be_valid
      end
      it "last_nameとfirst_nameが全角ひらがなであれば登録できる" do
        @user.last_name="あああ"
        @user.first_name="あああ"
        expect(@user).to be_valid
      end
      it "last_name_kanaとfirst_name_kanaが全角カタカナであれば登録できる" do 
        @user.last_name_kana="アアア"
        @user.first_name_kana="アアア"
        expect(@user).to be_valid
      end
    end

    context "新規登録できない時" do
      it "nicknameが空では登録できない" do
        @user.nickname=""
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it "emailが空では登録できない" do
        @user.email=""
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it "passwordが空では登録できない" do
        @user.password=""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it "password_confirmationが空では登録できない" do
        @user.password_confirmation=""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it "last_nameが空では登録できない" do
        @user.last_name=""
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
      it "first_nameが空では登録できない" do
        @user.first_name=""
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it "last_name_kanaが空では登録できない" do
        @user.last_name_kana=""
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end
      it "first_name_kanaが空では登録できない" do
        @user.first_name_kana=""
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end
      it "birth_dateが空では登録できない" do
        @user.birth_date=""
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth date can't be blank")
      end
      it "emailに@が含まれていない場合登録できない" do
        @user.email="testtest"
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end
      it "重複したemailが既に存在している場合登録できない" do
        @user.save
        another_user=FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Email has already been taken")        
      end
      it "passwordが5文字以下では登録できない" do
        @user.password="aaa11"
        @user.password_confirmation="aaa11"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
      it "passwordが全角文字が含まれていては登録できない" do
        @user.password="ａaa111"
        @user.password_confirmation="ａaa111"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid. Include both letters and numbers")
      end
      it "passwordが半角英字だけでは登録できない" do
        @user.password="aaaaaa"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid. Include both letters and numbers")
      end
      it "passwordが半角数字だけでは登録できない" do
        @user.password="111111"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid. Include both letters and numbers")
      end
      it "passwordとpassword_confirmationが一致していない場合登録できない" do
        @user.password="aaa111"
        @user.password_confirmation="bbb222"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it "last_nameが半角では登録できない" do
        @user.last_name="ｱｱｱ"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name is invalid. Input full-width characters")
      end
      it "first_nameが半角では登録できない" do
        @user.first_name="ｱｱｱ"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name is invalid. Input full-width characters")
      end
      it "last_name_kanaが半角では登録できない" do
        @user.last_name_kana="ｱｱｱ"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana is invalid. Input full-width katakana characters")
      end
      it "first_name_kanaが半角では登録できない" do
        @user.first_name_kana="ｱｱｱ"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana is invalid. Input full-width katakana characters")
      end
      it "last_name_kanaが全角漢字では登録できない" do
        @user.last_name_kana="阿阿阿"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana is invalid. Input full-width katakana characters")
      end
      it "first_name_kanaが全角漢字では登録できない" do
        @user.first_name_kana="阿阿阿"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana is invalid. Input full-width katakana characters")
      end
      it "last_name_kanaが全角ひらがなでは登録できない" do
        @user.last_name_kana="あああ"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana is invalid. Input full-width katakana characters")
      end
      it "first_name_kanaが全角ひらがなでは登録できない" do
        @user.first_name_kana="あああ"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana is invalid. Input full-width katakana characters")
      end
    end
  end
end
