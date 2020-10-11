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

100.times do |n|
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

50.times do |n|
  title = Faker::Food.dish
  content = Faker::Restaurant.description
  restaurant_url = Faker::Internet.url
  budget = Faker::Number.between(from: 0, to: 5)
  start_at = Faker::Time.forward(days: 30)
  end_at = Faker::Time.between(from: start_at + 60 * 60, to: (start_at + 60 * 60) + 180 * 60)
  check_in_time = Faker::Number.between(from: 0, to: 4)
  food_category = Faker::Number.between(from: 0, to: 4)
  user_id = Faker::Number.between(from: 1, to: 100)
  area_id = Faker::Number.between(from: 1, to: 23)

  if check_in_time == 0
    expired_time = start_at - 60 * 60
  elsif check_in_time == 1
    expired_time = start_at - 120 * 60
  elsif check_in_time == 2
    expired_time = start_at - 180 * 60
  elsif check_in_time == 3
    expired_time = start_at - 24 * 60 * 60
  elsif check_in_time == 4
    expired_time = start_at - 48 * 60 * 60
  end

  Event.create!(
    title: title,
    content: content,
    restaurant_url: restaurant_url,
    budget: budget,
    start_at: start_at,
    end_at: end_at,
    check_in_time: check_in_time,
    food_category: food_category,
    user_id: user_id,
    event_status: 0,
    area_id: area_id,
    expired_time: expired_time
  )
end

Event.all.each do |event|
  genre_id = Faker::Number.between(from: 1, to: 6)
  GenreTag.create!(
    genre_id: genre_id,
    event_id: event.id,
  )
end

event_users = User.all.select { |u| u.events.exists? }

except_users0 = User.all.reject { |u| u.id == event_users[0].id }
5.times do |i|
  event_users[0].events.each do |event|
    user_id = except_users0.sample.id
    except_users0.pluck(:id).reject! { |u| u == user_id }
    ApplyForEvent.create!(
      user_id: user_id,
      event_id: event.id
    )
  end
end

except_users1 = User.all.reject { |u| u.id == event_users[1].id }
5.times do |i|
  event_users[1].events.each do |event|
    user_id = except_users1.sample.id
    except_users1.pluck(:id).reject! { |u| u == user_id }
    ApplyForEvent.create!(
      user_id: user_id,
      event_id: event.id
    )
  end
end

except_users2 = User.all.reject { |u| u.id == event_users[2].id }
5.times do |i|
  event_users[2].events.each do |event|
    user_id = except_users2.sample.id
    except_users2.pluck(:id).reject! { |u| u == user_id }
    ApplyForEvent.create!(
      user_id: user_id,
      event_id: event.id
    )
  end
end

except_users3 = User.all.reject { |u| u.id == event_users[3].id }
5.times do |i|
  event_users[3].events.each do |event|
    user_id = except_users3.sample.id
    except_users3.pluck(:id).reject! { |u| u == user_id }
    ApplyForEvent.create!(
      user_id: user_id,
      event_id: event.id
    )
  end
end

except_users4 = User.all.reject { |u| u.id == event_users[4].id }
5.times do |i|
  event_users[4].events.each do |event|
    user_id = except_users4.sample.id
    except_users4.pluck(:id).reject! { |u| u == user_id }
    ApplyForEvent.create!(
      user_id: user_id,
      event_id: event.id
    )
  end
end

except_users5 = User.all.reject { |u| u.id == event_users[5].id }
5.times do |i|
  event_users[5].events.each do |event|
    user_id = except_users5.sample.id
    except_users5.pluck(:id).reject! { |u| u == user_id }
    ApplyForEvent.create!(
      user_id: user_id,
      event_id: event.id
    )
  end
end
