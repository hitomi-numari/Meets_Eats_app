FactoryBot.define do
  factory :genre do
    name { "恋愛" }
  end
  factory :genre2 do, class: Label do
    name { "仕事" }
  end
  factory :genre3 do, class: Label do
    name { "家族" }
  end
  factory :genre4 do, class: Label do
    name { "人間関係" }
  end
  factory :genre5 do, class: Label do
    name { "趣味" }
  end
  factory :genre6 do, class: Label do
    name { "その他" }
  end

end
