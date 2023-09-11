class Stock < ApplicationRecord
  belongs_to :user

  with_options presence: true do
    validates :p_name
    validates :category_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :remaining_in_can, numericality: { message: 'should be a number' }
    validates :amount, numericality: { message: 'should be a number' }
    validates :standard_id, numericality: { other_than: 1, message: "can't be blank" }
  end
end
