FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { 'password' }
    uid { SecureRandom.uuid }
    provider { 'google' }
    image { Faker::Avatar.image }
    token { Faker::Alphanumeric.alphanumeric(number: 20) }
    refresh_token { Faker::Alphanumeric.alphanumeric(number: 20) }
  end
end
