# アプリケーション名
Easy Stock Paint

# アプリケーション概要
塗料在庫をスマホから簡単に追加可能。<br>
PC画面から一覧確認が可能で、残量や塗布可能面積の面倒な計算の手間が省ける。

# URL
https://e-s-paint.onrender.com

# テスト用アカウント
・ Basic認証ID ：admin<br>
・ Basic認証パスワード ：22223<br>
・ メールアドレス ：test1@test.com<br>
・ パスワード ：testtest11<br>

# 利用方法

## 製品情報追加
1.ヘッダー部分から（製品情報追加）をクリック<br>
2.製品情報（塗料名・カテゴリー・標準塗布量・規格）を入力し追加する。

## 在庫追加

### 製品情報を用いない場合
1.ヘッダー部分から（在庫追加）をクリック<br>
2.在庫情報（塗料名・カテゴリー・色相・光沢・総重量・標準塗布量・規格・備考）を入力し追加する。<br>
3.一覧画面より入力した内容と計算済みの値が確認出来る。

### 製品情報を用いる場合
1.ヘッダー部分から（在庫追加）をクリック<br>
2.[製品を選択したください]から製品名を選択する。<br>
3.在庫情報（色相・光沢・総重量・備考）を入力し追加する。<br>
4.一覧画面より入力した内容と計算済みの値が確認出来る。

## 在庫情報編集・削除

### 在庫情報編集
1.編集を行いたい製品の製品名をクリック<br>
2.編集したい項目を入力し更新する。<br>
3.一覧画面より変更した内容と計算済みの値が確認出来る。

### 在庫情報削除
1.削除したい製品の製品名をクリック<br>
2.この在庫情報を削除をクリック<br>
3.一覧画面より削除した製品情報が表示されていないことが確認出来る。

# アプリケーションを作成した背景
前職では塗料メーカーの営業として戸建て外壁用の塗料を販売していた。その際、<br>
在庫管理の重要性に対する、管理を始めるまでのハードルの高さに課題を感じていた。<br>
そこでスマホからでも入力がしやすい在庫アプリがあればと考え、開発することにした。<br>


# 洗い出した要件
https://docs.google.com/spreadsheets/d/1EJIv2Ru2mFMoq4uq9tEyHYcQ3jmQezP7EPWPx2kDmFY/edit?usp=sharing

# 実装した機能について

[![Image from Gyazo](https://i.gyazo.com/1a1c08b18c11aa42e8dfd8b6648f5bb6.gif)](https://gyazo.com/1a1c08b18c11aa42e8dfd8b6648f5bb6)<br>
保存した製品名を選択することで自動入力される。

# 実装予定の機能
一斗缶以外の缶についても、プルダウンから選択することで<br>
重量等の計算を自動化する機能を検討中。

# データベース設計
[![Image from Gyazo](https://i.gyazo.com/254c08b5b3408821e5df6a20dddd8a38.png)](https://gyazo.com/254c08b5b3408821e5df6a20dddd8a38)

# 画面遷移図
[![Image from Gyazo](https://i.gyazo.com/5d5c9317aad1601a0be036b6140a1369.png)](https://gyazo.com/5d5c9317aad1601a0be036b6140a1369)

# 開発環境
・フロントエンド：HTML、CSS、JavaScript、Bootstrap<br>
・バックエンド：Ruby、Ruby on Rails<br>
・インフラ：Render<br>
・データベース：PostgreSQL<br>
・テスト：Rspec<br>
・テキストエディタ：Visual Studio Code<br>

# ローカルでの動作方法
以下のコマンドを順に実行<br>
% git clone https://github.com/ohkuma90/e-s-paint.git<br>
% cd e-s-paint<br>
% bundle install<br>
% yarn install<br>

# 工夫したポイント
出来る限り扱いやすく、分かりやすいアプリケーションにしたかった為<br>
シンプルに、画面遷移や入り組んだ機能の少ない設計とした。<br>
また、普段パソコンに触る機会が少ない職人さん達にも手軽に<br>
使用して頂く為にスマホからの在庫管理を可能にした。<br>
スマホでも扱う事を考えて、ビューは初めからBootstrapを導入し<br>
開発のコストを小さくした。

# テーブル設計

## usersテーブル

| Column             | Type   | Options                    |
| ------------------ | ------ | -------------------------- |
| name               | string | null: false                |
| email              | string | null: false , unique: true |
| encrypted_password | string | null: false                |

### Association

- has_many :stocks
- has_many :p_information

## stocksテーブル

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| p_name           | string     | null: false                    |
| category_id      | integer    | null: false                    |
| color            | string     |                                |
| gloss            | string     |                                |
| remaining_in_can | float      | null: false                    |
| amount           | float      | null: false                    |
| standard_id      | integer    | null: false                    |
| remarks          | text       |                                |
| user             | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :p_information


## p_information テーブル

| Column      | Type    | Options     |
| ----------- | ------- | ----------- |
| p_name      | string  | null: false |
| category_id | string  | null: false |
| amount      | integer | null: false |
| standard_id | integer | null: false |

### Association

- has_many :stocks
- belongs_to :user