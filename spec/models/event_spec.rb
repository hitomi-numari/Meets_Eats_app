require 'rails_helper'
RSpec.describe Event, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @area = FactoryBot.create(:area13)
  end

  it 'イベントのタイトルが空の場合バリデーションにひっかる' do
    area = @area
    user = @user
    event = Event.create(
      title: '',
      content: '渋谷でパスタを食べながら恋話をしたい',
      restaurant_url: 'https://tabelog.com/tokyo/A1303/A130301/13010743/',
      budget: 'till_2000',
      start_at: '2020-10-01 12:00:00 +0900',
      end_at: '2020-10-01 14:00:00 +0900',
      check_in_time: 'before_24hours',
      food_category: 'その他',
      expired_time: '2020-09-30 12:00:00 +0900',
      user_id: user.id,
      area_id: area.id
    )
    expect(event).not_to be_valid
    expect(event.errors[:title]).to include("を入力してください")
  end

  it 'イベントの詳細が空の場合バリデーションにひっかかる' do
    area = @area
    user = @user
    event = Event.create(
      title: 'Aの会',
      content: '',
      restaurant_url: 'https://tabelog.com/tokyo/A1303/A130301/13010743/',
      budget: 'till_2000',
      start_at: '2020-10-01 12:00:00 +0900',
      end_at: '2020-10-01 14:00:00 +0900',
      check_in_time: 'before_24hours',
      food_category: 'その他',
      expired_time: '2020-09-30 12:00:00 +0900',
      user_id: user.id,
      area_id: area.id
    )
    expect(event).not_to be_valid
    expect(event.errors[:content]).to include("を入力してください")
  end

  it 'イベントのレストランURLがURLでない場合バリデーションにひっかかる' do
    area = @area
    user = @user
    event = Event.create(
      title: 'Aの会',
      content: '渋谷でパスタを食べながら恋話をしたい',
      restaurant_url: 'nobita@doraemon.com',
      budget: 'till_2000',
      start_at: '2020-10-01 12:00:00 +0900',
      end_at: '2020-10-01 14:00:00 +0900',
      check_in_time: 'before_24hours',
      food_category: 'その他',
      expired_time: '2020-09-30 12:00:00 +0900',
      user_id: user.id,
      area_id: area.id
    )
    expect(event).not_to be_valid
    expect(event.errors[:restaurant_url]).to include("は不正な値です")
  end

  it 'イベントのレストランURLがURLである場合バリデーションにひっかからない' do
    area = @area
    user = @user
    event = Event.create(
      title: 'Aの会',
      content: '渋谷でパスタを食べながら恋話をしたい',
      restaurant_url: 'https://tabelog.com/tokyo/A1303/A130301/13010743/',
      budget: 'till_2000',
      start_at: '2020-10-01 12:00:00 +0900',
      end_at: '2020-10-01 14:00:00 +0900',
      check_in_time: 'before_24hours',
      food_category: 'その他',
      expired_time: '2020-09-30 12:00:00 +0900',
      user_id: user.id,
      area_id: area.id
    )
    expect(event).to be_valid
  end

  it 'イベントの予算が空の場合バリデーションにひっかかる' do
    area = @area
    user = @user
    event = Event.create(
      title: 'Aの会',
      content: '渋谷でパスタを食べながら恋話をしたい',
      restaurant_url: 'https://tabelog.com/tokyo/A1303/A130301/13010743/',
      budget: '',
      start_at: '2020-10-01 12:00:00 +0900',
      end_at: '2020-10-01 14:00:00 +0900',
      check_in_time: 'before_24hours',
      food_category: 'その他',
      expired_time: '2020-09-30 12:00:00 +0900',
      user_id: user.id,
      area_id: area.id
    )
    expect(event).not_to be_valid
  end

  it 'イベントの終了時間が開始時間と同じだったらバリデーションに引っかかる' do
    area = @area
    user = @user
    event = Event.create(
      title: 'Aの会',
      content: '渋谷でパスタを食べながら恋話をしたい',
      restaurant_url: 'https://tabelog.com/tokyo/A1303/A130301/13010743/',
      budget: 'till_2000',
      start_at: '2020-10-01 12:00:00 +0900',
      end_at: '2020-10-01 12:00:00 +0900',
      check_in_time: 'before_24hours',
      food_category: 'その他',
      expired_time: '2020-09-30 12:00:00 +0900',
      user_id: user.id,
      area_id: area.id
    )
    expect(event).not_to be_valid
  end

  it 'イベントの受付時間が空の場合バリデーションにひっかかる' do
    area = @area
    user = @user
    event = Event.create(
      title: 'Aの会',
      content: '渋谷でパスタを食べながら恋話をしたい',
      restaurant_url: 'https://tabelog.com/tokyo/A1303/A130301/13010743/',
      budget: 'till_2000',
      start_at: '2020-10-01 12:00:00 +0900',
      end_at: '2020-10-01 12:00:00 +0900',
      check_in_time: '',
      food_category: 'その他',
      expired_time: '2020-09-30 12:00:00 +0900',
      user_id: user.id,
      area_id: area.id
    )
    expect(event).not_to be_valid

  end
end
