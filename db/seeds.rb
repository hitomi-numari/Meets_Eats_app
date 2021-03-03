# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


api_key = ENV["API"]
url = "http://webservice.recruit.co.jp/hotpepper/gourmet/v1/?key=#{api_key}&format=json"

large_area_url = "http://webservice.recruit.co.jp/hotpepper/large_area/v1/?key=#{api_key}&format=json"
large_area_url=URI.encode(large_area_url) #エスケープ
uri = URI.parse(large_area_url)
json = Net::HTTP.get(uri)
before_large_area_select = JSON.parse(json)["results"]["large_area"]
large_area_select = before_large_area_select.map { |r| ["#{r['name']}", "#{r['code']}"] }

middle_area_url = "http://webservice.recruit.co.jp/hotpepper/middle_area/v1/?key=#{api_key}&format=json"
middle_area_url=URI.encode(middle_area_url) #エスケープ
uri = URI.parse(middle_area_url)
json = Net::HTTP.get(uri)
before_middle_area_select = JSON.parse(json)["results"]["middle_area"]
middle_area_select = before_middle_area_select.map { |r| ["#{r['name']}", "#{r['code']}"] }
large_area_group = []
before_large_area_select.each do |l|
  a = []
  b = []
  a << l['code']
  before_middle_area_select.each do |m|
    if m["large_area"]["name"] == l["name"]
      b << ["#{m['name']}", "#{m['code']}"]
    end
  end
  a << b
  large_area_group << a
end

large_area_group[0][1].each do |group|
Area.create!(
  name:group[0]
)
end

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
  start_at = Faker::Time.forward(days: 30)
  end_at = Faker::Time.between(from: start_at + 60 * 60, to: (start_at + 60 * 60) + 180 * 60)
  check_in_time = Faker::Number.between(from: 0, to: 4)
  food_category = Faker::Number.between(from: 0, to: 4)
  user_id = Faker::Number.between(from: 1, to: 100)
  area_id = Faker::Number.between(from: 1, to: 48)
  restaurant_name = Faker::Restaurant.name
  restaurant_access = Faker::Address.street_address

  budget_url = "http://webservice.recruit.co.jp/hotpepper/budget/v1/?key=#{api_key}&format=json"
  budget_url=URI.encode(budget_url)
  uri = URI.parse(budget_url)
  json = Net::HTTP.get(uri)
  budget_select = JSON.parse(json)["results"]["budget"]
  budget_select = budget_select.map{ |r| r['name']}
  budget = budget_select.sample

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
    start_at: start_at,
    end_at: end_at,
    check_in_time: check_in_time,
    food_category: food_category,
    user_id: user_id,
    event_status: 0,
    expired_time: expired_time,
    area_id: area_id,
    restaurant_name: restaurant_name,
    restaurant_access: restaurant_access,
    # restaurant_img: File.open('./public/uploads/profile/icon/restaurant_9983-300x300.png'),
    budget: budget
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
