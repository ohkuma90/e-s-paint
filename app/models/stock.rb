class Stock < ApplicationRecord
  belongs_to :user
  belongs_to :p_information, optional: true

  # 仮想属性の追加
  attr_accessor :remaining, :applicable_area

  with_options presence: true do
    validates :p_name
    validates :category_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :remaining_in_can, numericality: true
    validates :amount, numericality: true
    validates :standard_id, numericality: { other_than: 1, message: "can't be blank" }
  end

  def self.search(search, user_id)
    if search.present?
      Stock.where('p_name LIKE(?) OR color LIKE(?)', "%#{search}%", "%#{search}%").where(user_id: user_id)
    else
      Stock.where(user_id: user_id)
    end
  end


  # アクティブハッシュのアソシエーション
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :standard
  
end
