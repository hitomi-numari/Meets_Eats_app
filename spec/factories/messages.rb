FactoryBot.define do
  factory :message do
    content { "MyText" }
    room { nil }
    user { nil }
    read { false }
  end
end
