require 'faker'

FactoryGirl.define do
  factory :writing do
    title { Faker::Lorem.sentence(6) }
    content { Faker::Lorem.paragraphs }
    summary { Faker::Lorem.paragraph }
  end
end