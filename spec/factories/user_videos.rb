FactoryBot.define do
  factory :user_video do
    association :user
    title { Faker::Lorem.sentence}
    url { "https://www.youtube.com/"}
    embed_url { "http://www.youtube.com/embed/test" }
    duration { "PT5M13S" }
    duration_category { "medium" }
  end
end 