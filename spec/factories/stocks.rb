FactoryBot.define do
  factory :stock do
    p_name { Faker::Commerce.product_name }
    category_id { rand(2..Category.count) }
    color { Faker::Color.color_name }
    gloss { "艶あり" }
    remaining_in_can {Faker::Number.decimal(l_digits: 1, r_digits: 1)}
    amount { 0.15 }
    standard_id { rand(2..Standard.count) }
    remarks { "佐藤様邸使用予定・缶へこみ" }
    association :user
  end
end
