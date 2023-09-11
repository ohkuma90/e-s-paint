require 'rails_helper'

RSpec.describe Stock, type: :model do
  before do
    @stock = FactoryBot.build(:stock)
  end

  describe '在庫追加' do

    context '在庫追加できる場合' do
      it '全ての項目が正しく入力されていれば保存できる' do
        expect(@stock).to be_valid
      end

      it 'colorが入力されていなくても保存できる' do
        @stock.color = ''
        expect(@stock).to be_valid
      end

      it 'glossが入力されていなくても保存できる' do
        @stock.gloss = ''
        expect(@stock).to be_valid
      end

      it 'remarksが入力されていなくても保存できる' do
        @stock.remarks = ''
        expect(@stock).to be_valid
      end
    end

    context '在庫追加できない場合' do
      it 'p_nameが空では保存できない' do
        @stock.p_name = ''
        @stock.valid?
        expect(@stock.errors.full_messages).to include("P name can't be blank")
      end

      it 'category_idが空では保存できない' do
        @stock.category_id = ''
        @stock.valid?
        expect(@stock.errors.full_messages).to include("Category can't be blank")
      end

      it 'category_idが1では保存できない' do
        @stock.category_id = 1
        @stock.valid?
        expect(@stock.errors.full_messages).to include("Category can't be blank")
      end

      it 'remaining_in_canが空では保存できない' do
        @stock.remaining_in_can = ''
        @stock.valid?
        expect(@stock.errors.full_messages).to include("Remaining in can can't be blank")
      end

      it 'remaining_in_canが文字列では保存できない' do
        @stock.remaining_in_can = 'aaaaa'
        @stock.valid?
        expect(@stock.errors.full_messages).to include("Remaining in can should be a number")
      end

      it 'amountが空では保存できない' do
        @stock.amount = ''
        @stock.valid?
        expect(@stock.errors.full_messages).to include("Amount can't be blank")
      end

      it 'amountが文字列では保存できない' do
        @stock.amount = 'aaaaa'
        @stock.valid?
        expect(@stock.errors.full_messages).to include("Amount should be a number")
      end

      it 'standard_idが空では保存できない' do
        @stock.standard_id = ''
        @stock.valid?
        expect(@stock.errors.full_messages).to include("Standard can't be blank")
      end

      it 'standard_idが1では保存できない' do
        @stock.standard_id = 1
        @stock.valid?
        expect(@stock.errors.full_messages).to include("Standard can't be blank")
      end
      
    end
  end


end
