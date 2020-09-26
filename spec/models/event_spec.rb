require 'rails_helper'

RSpec.describe Event, type: :model do
  it 'ベントのタイトルが空の場合バリデーションにひっかる' do
    event = Event.new(title: '', content: '失敗テスト')
    expect(event).not_to be_valid
  end
  it 'イベントの詳細が空の場合バリデーションにひっかかる' do
    event = Event.new(title: '失敗テスト', content: '')
    expect(event).not_to be_valid
  end
  it 'イベントのレストランURLがURLでない場合バリデーションにひっかかる' do
    event = Event.new(restaurant_url: 'nobita@doraemon.com')
    expect(event).not_to be_valid
  end
  it 'イベントの予算が空の場合バリデーションにひっかかる' do
    event = Event.new(budget: "")
    expect(event).not_to be_valid
  end
  it 'イベントの受付時間が空の場合バリデーションにひっかかる' do
    event = Event.new(check_in_time: "")
    expect(event).not_to be_valid
  end
end
