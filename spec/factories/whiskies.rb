FactoryBot.define do
  factory :whisky do
    association :user

    whisky_name   { "山崎12年" }
    drink_style   { "straight" }
    glass_name    { "テイスティンググラス" }
    glass_rating  { 4 }
    peat          { true }
    details       { "とても香り豊かで良い味わい" }
    aromas        { ["sweet", "citrus"] }
  end
end