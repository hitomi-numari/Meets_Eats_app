FactoryBot.define do
  factory :user do
    email { "nobita@doraemon.com" }
    password { "password" }
    password_confirmation { "password" }
  end

  factory :second_user, class: User do
    email { "shizuka@doraemon.com" }
    password { "password" }
    password_confirmation { "password" }
  end

  factory :third_user, class: User do
    email { "suneo@doraemon.com" }
    password { "password" }
    password_confirmation { "password" }
  end


end
