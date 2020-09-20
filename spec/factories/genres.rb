FactoryBot.define do
  factory :genre do
    name { "恋愛" }
  end
  factory :genre2, class: Genre do
    name { "仕事" }
  end
  factory :genre3, class: Genre do
    name { "家族" }
  end
  factory :genre4, class: Genre do
    name { "人間関係" }
  end
  factory :genre5, class: Genre do
    name { "趣味" }
  end
  factory :genre6, class: Genre do
    name { "その他" }
  end

end
