require 'faker'

FactoryGirl.define do
  factory :writing do
    title { Faker::Lorem.sentence(6) }
    content { Faker::Lorem.paragraphs.join('\n\n') }
    summary { Faker::Lorem.sentence }
    published_at Time.now - 1.day
  end

  factory :invalid_writing, parent: :writing do
    title nil
  end

  factory :draft_writing, parent: :writing do
    published_at nil
  end

end
