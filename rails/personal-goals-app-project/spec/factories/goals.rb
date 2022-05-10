FactoryBot.define do
  factory :goal do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
  end
end
