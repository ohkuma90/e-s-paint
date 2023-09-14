require 'rails_helper'

RSpec.describe "製品情報追加", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @p_information = FactoryBot.build(:p_information)
    basic_pass root_path
  end

  context '製品情報追加ができるとき'do
    it 'ログインしたユーザーは製品情報追加できる' do
      # ログインする
      sign_in(@user)
      # 製品情報追加ページへのボタンがあることを確認する
      expect(page).to have_content('製品情報追加')
      # 投稿ページに移動する
      visit new_p_information_path
      # フォームに情報を入力する
      fill_in 'p_information[p_name]', with: @p_information.p_name
      select @p_information.category.name, from: 'p_information[category_id]'
      fill_in 'p_information_amount', with: @p_information.amount
      select @p_information.standard.name, from: 'p_information[standard_id]'
      # 送信するとStockモデルのカウントが1上がることを確認する
      expect{
        click_button '追加する'
        sleep 1
      }.to change { PInformation.count }.by(1)
      # 一覧ページに遷移したことを確認
      expect(current_path).to eq(root_path)
      # 在庫追加ページに移動する
      visit new_stock_path
      #製品情報選択をクリックする
      expect(page).to have_content(@p_information.p_name)
    end
  end
end
