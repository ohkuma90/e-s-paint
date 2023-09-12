require 'rails_helper'

RSpec.describe PInformation, type: :model do
  before do
    @p_information = FactoryBot.build(:p_information)
  end

  describe '製品情報追加' do

    context '製品情報追加できる場合' do
      it '全ての項目が正しく入力されていれば保存できる' do
        expect(@p_information).to be_valid
      end
    end

    context '製品情報追加できない場合' do
      it 'p_nameが空では保存できない' do
        @p_information.p_name = ''
        @p_information.valid?
        expect(@p_information.errors.full_messages).to include("P name can't be blank")
      end

      it 'category_idが空では保存できない' do
        @p_information.category_id = ''
        @p_information.valid?
        expect(@p_information.errors.full_messages).to include("Category can't be blank")
      end

      it 'category_idが1では保存できない' do
        @p_information.category_id = 1
        @p_information.valid?
        expect(@p_information.errors.full_messages).to include("Category can't be blank")
      end

      it 'amountが空では保存できない' do
        @p_information.amount = ''
        @p_information.valid?
        expect(@p_information.errors.full_messages).to include("Amount can't be blank")
      end

      it 'amountが文字列では保存できない' do
        @p_information.amount = 'aaaaa'
        @p_information.valid?
        expect(@p_information.errors.full_messages).to include("Amount is not a number")
      end

      it 'amountが全角数字では保存できない' do
        @p_information.amount = '１１．５'
        @p_information.valid?
        expect(@p_information.errors.full_messages).to include("Amount is not a number")
      end

      it 'standard_idが空では保存できない' do
        @p_information.standard_id = ''
        @p_information.valid?
        expect(@p_information.errors.full_messages).to include("Standard can't be blank")
      end

      it 'standard_idが1では保存できない' do
        @p_information.standard_id = 1
        @p_information.valid?
        expect(@p_information.errors.full_messages).to include("Standard can't be blank")
      end
    end
  end
end