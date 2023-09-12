# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

# テーブル設計

## usersテーブル

| Column             | Type   | Options                    |
| ------------------ | ------ | -------------------------- |
| name               | string | null: false                |
| email              | string | null: false , unique: true |
| encrypted_password | string | null: false                |

### Association

- has_many :stocks


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

| Column           | Type    | Options     |
| ---------------- | ------- | ----------- |
| p_name           | string  | null: false |
| category         | string  | null: false |
| amount           | integer | null: false |
| standard         | integer | null: false |

### Association

- has_many :stocks