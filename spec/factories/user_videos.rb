FactoryBot.define do
  factory :user_video do
    association :user
    title { Faker::Lorem.sentence}
    url { "https://www.youtube.com/"}
  end
end 