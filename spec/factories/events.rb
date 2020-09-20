FactoryBot.define do
  factory :event do
    title { Faker::Food.dish }
    content { Faker::Restaurant.description }
    restaurant_url { Faker::Internet.url }
    budget { Faker::Number.between(from: 1, to: 6) }
    start_at { Faker::Time.forward(days: 30) }
    end_at { Faker::Time.between(from: start_at, to: start_at + 180 * 60) }
    check_in_time { Faker::Number.between(from: 1, to: 5) }
    food_category { Faker::Number.between(from: 0, to: 4) }
    user
    area
  end
end
