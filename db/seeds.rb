# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Area.create!(
  name:'千代田区'
)
Area.create!(
  name:'中央区'
)
Area.create!(
  name:'港区'
)
Area.create!(
  name:'新宿区'
)
Area.create!(
  name:'文京区'
)
Area.create!(
  name:'台東区'
)
Area.create!(
  name:'墨田区'
)
Area.create!(
  name:'江東区'
)
Area.create!(
  name:'品川区'
)
Area.create!(
  name:'目黒区'
)
Area.create!(
  name:'太田区'
)
Area.create!(
  name:'世田谷区'
)
Area.create!(
  name:'渋谷区'
)
Area.create!(
  name:'中野区'
)
Area.create!(
  name:'杉並区'
)
Area.create!(
  name:'豊島区'
)
Area.create!(
  name:'北区'
)
Area.create!(
  name:'荒川区'
)
Area.create!(
  name:'板橋区'
)
Area.create!(
  name:'練馬区'
)
Area.create!(
  name:'足立区'
)
Area.create!(
  name:'葛飾区'
)
Area.create!(
  name:'江戸川区'
)

Genre.create!(
  name:'恋愛'
)
Genre.create!(
  name:'仕事'
)
Genre.create!(
  name:'家族'
)
Genre.create!(
  name:'人間関係'
)
Genre.create!(
  name:'趣味'
)
Genre.create!(
  name:'その他'
)

20.times do |n|
  email = Faker::Internet.email
  password = "password"
  User.create!(email: email,
               password: password,
               password_confirmation: password,
               )
end

User.all.each do |user|
  nickname = Faker::Name.name
  bitrhday = Faker::Date.birthday(min_age: 18, max_age: 65)
  gender = Faker::Number.between(from: 0, to: 2)
  url = Faker::Internet.url(host: 'example.com')
  details = Faker::Lorem.sentence
  Profile.create!(
    nickname: nickname,
    icon: File.open('./public/uploads/profile/icon/default.png'),
    birthday: bitrhday,
    gender: gender,
    instagram_url: url,
    facebook_url: url,
    details: details,
    user_id: user.id
  )
end
