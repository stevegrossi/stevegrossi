require 'faker'

FactoryGirl.define do
  factory :writing do
    title { Faker::Lorem.sentence(6) }
    content { Faker::Lorem.paragraphs }
    summary { Faker::Lorem.paragraph }
    published_at Time.now - 1.day
  end

  factory :invalid_writing, parent: :writing do
    title nil
  end

end