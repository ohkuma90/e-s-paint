require 'rails_helper'

RSpec.describe "在庫追加", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @stock = FactoryBot.create(:stock)
    basic_pass root_path
  end

  context '在庫追加ができるとき'do
    it 'ログインしたユーザーは新規投稿できる' do
      # ログインする
      sign_in(@user)
      # 在庫追加ページへのボタンがあることを確認する
      expect(page).to have_content('在庫追加')
      # 投稿ページに移動する
      visit new_stock_path
      # フォームに情報を入力する
      fill_in 'stock[p_name]', with: @stock.p_name
      select @stock.category.name, from: 'stock[category_id]'
      fill_in 'stock_color', with: @stock.color
      fill_in 'stock_gloss', with: @stock.gloss
      fill_in 'stock_remaining_in_can', with: @stock.remaining_in_can
      fill_in 'stock_amount', with: @stock.amount
      select @stock.standard.name, from: 'stock[standard_id]'
      fill_in 'stock_remarks', with: @stock.remarks
      # 送信するとStockモデルのカウントが1上がることを確認する
      expect{
        click_button '追加する'
        sleep 1
      }.to change { Stock.count }.by(1)
      # トップページには先ほど投稿した内容の在庫が存在することを確認する
      expect(page).to have_content(@stock.p_name)
      expect(page).to have_content(@stock.created_at.to_date)
      expect(page).to have_content(@stock.color)
      expect(page).to have_content(@stock.gloss)
      stock_remaining = (@stock.remaining_in_can.to_f - 1.14).round(2)
      expect(page).to have_content(stock_remaining)
      stock_applicable_area = (stock_remaining / @stock.amount).round(2)
      expect(page).to have_content(stock_applicable_area)
      expect(page).to have_content(stock_applicable_area.to_s)
      expect(page).to have_content(@stock.remarks)
    end
  end

  context '在庫追加ができないとき'do
    it 'ログインしていないと新規投稿ページに遷移できない' do
      # トップページに遷移する
      visit root_path
      # 在庫追加ページへのボタンがないことを確認する
      expect(page).not_to have_link("在庫追加", href: new_stock_path)
    end
  end
end

RSpec.describe '在庫編集', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @stock = FactoryBot.create(:stock, user: @user)
    @stock2 = FactoryBot.create(:stock, user: @user)
    sign_in @user
  end
  context '在庫編集ができるとき' do
    it 'ログインしたユーザーは自分が投稿した在庫の編集ができる' do
      # 編集ページにアクセス
      visit edit_stock_path(@stock)
      # 編集ページに遷移したことを確認
      expect(current_path).to eq(edit_stock_path(@stock))
      # すでに投稿済みの内容がフォームに入っていることを確認
      expect(find_field('stock[p_name]').value).to eq @stock.p_name
      expect(find_field('stock[color]').value).to eq @stock.color
      expect(find_field('stock[gloss]').value).to eq @stock.gloss
      expect(find_field('stock[remaining_in_can]').value).to eq @stock.remaining_in_can.to_s
      expect(find_field('stock[amount]').value).to eq @stock.amount.to_s
      expect(find_field('stock[standard_id]').value).to eq @stock.standard_id.to_s
      expect(find_field('stock[remarks]').value).to eq @stock.remarks
      # 投稿内容を編集する
      fill_in 'stock[p_name]', with: @stock2.p_name
      select @stock2.category.name, from: 'stock[category_id]'
      fill_in 'stock_color', with: @stock2.color
      fill_in 'stock_gloss', with: @stock2.gloss
      fill_in 'stock_remaining_in_can', with: @stock2.remaining_in_can
      fill_in 'stock_amount', with: @stock2.amount
      select @stock2.standard.name, from: 'stock[standard_id]'
      fill_in 'stock_remarks', with: @stock2.remarks
      # 編集してもStockモデルのカウントは変わらないことを確認
      expect {
        click_button '更新する'
        sleep 1
        @stock.reload
      }.to_not change { Stock.count }
      # トップページには変更した内容の在庫が表示されていることを確認
      visit root_path
      expect(page).to have_content(@stock2.p_name)
      expect(page).to have_content(@stock2.created_at.to_date)
      expect(page).to have_content(@stock2.color)
      expect(page).to have_content(@stock2.gloss)
      stock_remaining = (@stock2.remaining_in_can.to_f - 1.14).round(2)
      expect(page).to have_content(stock_remaining)
      stock_applicable_area = (stock_remaining / @stock2.amount).round(2)
      expect(page).to have_content(stock_applicable_area)
      expect(page).to have_content(stock_applicable_area.to_s)
      expect(page).to have_content(@stock2.remarks)
    end
  end
end

RSpec.describe '在庫削除', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @stock = FactoryBot.create(:stock, user: @user)
    sign_in @user
  end
  context '在庫削除ができるとき' do
    it 'ログインしたユーザーは自らが投稿した在庫の削除ができる' do
      # トップページに遷移する
      visit root_path
      # 在庫の製品名が表示されていることを確認する
      expect(page).to have_content(@stock.p_name)
      # 在庫の製品名をクリックして編集ページにアクセスする
      click_link @stock.p_name
      # 在庫の編集ページに「この在庫情報を削除」へのリンクが存在することを確認する
      expect(page).to have_link 'この在庫情報を削除', href: stock_path(@stock)
      # 在庫を削除するとレコードの数が1減ることを確認する
      expect {
        click_link 'この在庫情報を削除'
        sleep 1 
      }.to change { Stock.count }.by(-1)
      # トップページには削除した在庫の内容が存在しないことを確認する
      expect(page).not_to have_content(@stock.p_name)
      expect(page).not_to have_content(@stock.created_at.to_date)
      expect(page).not_to have_content(@stock.color)
      expect(page).not_to have_content(@stock.gloss)
      stock_remaining = (@stock.remaining_in_can.to_f - 1.14).round(2)
      expect(page).not_to have_content(stock_remaining)
      stock_applicable_area = (stock_remaining / @stock.amount).round(2)
      expect(page).not_to have_content(stock_applicable_area)
      expect(page).not_to have_content(stock_applicable_area.to_s)
      expect(page).not_to have_content(@stock.remarks)
    end
  end
end