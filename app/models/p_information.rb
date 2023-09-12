class PInformation < ApplicationRecord
  has_many :stocks
  belongs_to :user

  with_options presence: true do
    validates :p_name
    validates :category_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :amount, numericality: true
    validates :standard_id, numericality: { other_than: 1, message: "can't be blank" }
  end
  # アクティブハッシュのアソシエーション
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :standard
end
