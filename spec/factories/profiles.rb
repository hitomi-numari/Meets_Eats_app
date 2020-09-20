FactoryBot.define do
  factory :profile do
    url = Faker::Internet.url(host: 'example.com')
    nickname { Faker::Name.name }
    icon { File.open('./public/uploads/profile/icon/default.png') }
    bitrhday { Faker::Date.birthday(min_age: 18, max_age: 65) }
    gender { Faker::Number.between(from: 0, to: 2) }
    instagram_url { url }
    facebook_url { url }
    details { Faker::Lorem.sentence }
    user
  end
end
