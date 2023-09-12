FactoryBot.define do
  factory :p_information do
    p_name { Faker::Commerce.product_name }
    category_id { rand(2..Category.count) }
    amount { 0.15 }
    standard_id { rand(2..Standard.count) }
    association :user
  end
end
