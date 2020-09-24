FactoryBot.define do
  factory :event do
    title { 'Aの会' }
    content { '渋谷でパスタを食べながら恋話をしたい' }
    restaurant_url { 'https://tabelog.com/tokyo/A1303/A130301/13010743/' }
    budget { 'till_2000' }
    start_at { '2020-10-01 12:00:00 +0900' }
    end_at { '2020-10-01 14:00:00 +0900' }
    check_in_time { 'before_24hours' }
    food_category { 'その他' }
    expired_time {'2020-09-30 12:00:00 +0900'}
    user
    area
  end

  factory :second_event, class: Event do
    title { 'Bの会' }
    content { '浅草で天ぷらを食べながら旦那の愚痴をしたい' }
    restaurant_url { 'https://tabelog.com/tokyo/A1303/A130301/13010743/' }
    budget { 'till_3000' }
    start_at { '2020-10-02 18:00:00 +0900' }
    end_at { '2020-10-02 19:00:00 +0900' }
    check_in_time { 'before_2hours' }
    food_category { '和食' }
    expired_time {'2020-10-02 16:00:00 +0900'}
    user
    area
  end

  factory :third_event, class: Event do
    title { 'Cの会' }
    content { '新大久保でサムギョプサルを食べながら韓流話をしたい' }
    restaurant_url { 'https://tabelog.com/tokyo/A1303/A130301/13010743/' }
    budget { 'till_4000' }
    start_at { '2020-10-03 19:00:00 +0900' }
    end_at { '2020-10-03 21:00:00 +0900' }
    check_in_time { 'before_48hours' }
    food_category { 'その他' }
    expired_time {'2020-10-01 16:00:00 +0900'}
    user
    area
  end

end
