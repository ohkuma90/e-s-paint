class Stock < ApplicationRecord
  belongs_to :user

  with_options presence: true do
    validates :p_name
    validates :category_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :remaining_in_can, numericality: true
    validates :amount, numericality: true
    validates :standard_id, numericality: { other_than: 1, message: "can't be blank" }
  end
end
