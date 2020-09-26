FactoryBot.define do
  factory :profile do
    nickname { 'のび太' }
    icon { Rack::Test::UploadedFile.new(File.join(Rails.root,'/spec/factories/images/nobita.png')) }
    birthday { '1990-05-20' }
    gender { 1 }
    instagram_url { "http://example.com/harland" }
    facebook_url { "http://example.com/harland" }
    details { "会社員、ゾンビ映画が大好き！" }
    user
  end

  factory :second_profile, class: Profile do
    nickname { '静香' }
    icon { Rack::Test::UploadedFile.new(File.join(Rails.root,'/spec/factories/images/shizuka.jpeg'))}
    birthday { '2000-10-03' }
    gender { 1 }
    instagram_url { "http://example.com/harland" }
    facebook_url { "http://example.com/harland" }
    details { "主婦、日頃の鬱憤を解消したい！" }
    user
  end

  factory :third_profile, class: Profile do
    nickname { 'スネ夫' }
    icon { Rack::Test::UploadedFile.new(File.join(Rails.root,'/spec/factories/images/suneo.jpg')) }
    birthday { '1985-03-15' }
    gender { 1 }
    instagram_url { "http://example.com/harland" }
    facebook_url { "http://example.com/harland" }
    details { "フリーター、韓国大好き！" }
    user
  end

end
