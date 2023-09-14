require 'rails_helper'

RSpec.describe "ユーザー新規登録", type: :system do
  before do
    @user = FactoryBot.build(:user)
    basic_pass root_path
  end

  context 'ユーザー新規登録ができるとき' do 
    it '正しい情報を入力すればユーザー新規登録ができてトップページに移動する' do
      # ログインページへ移動する
      visit new_user_session_path
      # ログインページにサインアップページ・ログインページへ遷移するボタンがあることを確認する
      expect(page).to have_content('新規登録')
      expect(page).to have_content('ログイン')
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in 'Name', with: @user.name
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      fill_in 'Password confirmation', with: @user.password_confirmation
      # サインアップボタンを押すとユーザーモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
        sleep 1
      }.to change { User.count }.by(1)
      # トップページへ遷移することを確認する
      expect(page).to have_current_path(root_path)
      # トップページにログアウトボタンや製品情報追加ボタン・在庫追加ボタンがあることを確認する
      expect(page).to have_content('ログアウト')
      expect(page).to have_content('在庫追加')
      expect(page).to have_content('製品情報追加')
      # サインアップページへ遷移するボタンや、ログインページへ遷移するボタンが表示されていないことを確認する
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_link('ログイン', href:'/users/sign_in')
    end
  end
  context 'ユーザー新規登録ができないとき' do 
    it '誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      # ログインページへ移動する
      visit new_user_session_path
      # ログインページにサインアップページ・ログインページへ遷移するボタンがあることを確認する
      expect(page).to have_content('新規登録')
      expect(page).to have_content('ログイン')
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in 'Name', with: ''
      fill_in 'Email', with: ''
      fill_in 'Password', with: ''
      fill_in 'Password confirmation', with: ''
      # サインアップボタンを押すとユーザーモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
        sleep 1
      }.to change { User.count }.by(0)
      # 新規登録ページへ戻されることを確認する
      expect(page).to have_current_path(new_user_registration_path)
    end
  end
end

RSpec.describe 'ログイン', type: :system do
  before do
    @user = FactoryBot.create(:user)
    basic_pass root_path
  end
  context 'ログインができるとき' do
    it '保存されているユーザーの情報と合致すればログインができる' do
      # ログインページへ移動する
      visit new_user_session_path
      # ログインページにサインアップページ・ログインページへ遷移するボタンがあることを確認する
      expect(page).to have_content('新規登録')
      expect(page).to have_content('ログイン')
      # 正しいユーザー情報を入力する
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      # ログインボタンを押す
      find('input[name="commit"]').click
      # トップページへ遷移することを確認する
      expect(page).to have_current_path(root_path)
      # サインアップページへ遷移するボタンやログインページへ遷移するボタンが表示されていないことを確認する
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_link('ログイン', href:'/users/sign_in')
    end
  end
  context 'ログインができないとき' do
    it '保存されているユーザーの情報と合致しないとログインができない' do
      # ログインページへ移動する
      visit new_user_session_path
      # ログインページにサインアップページ・ログインページへ遷移するボタンがあることを確認する
      expect(page).to have_content('新規登録')
      expect(page).to have_content('ログイン')
      # ユーザー情報を入力する
      fill_in 'Email', with: ''
      fill_in 'Password', with: ''
      # ログインボタンを押す
      find('input[name="commit"]').click
      # ログインページへ戻されることを確認する
      expect(page).to have_current_path(new_user_session_path)
    end
  end
end