require 'faker'

FactoryGirl.define do
  factory :work do
    title { Faker::Lorem.sentence }
    about { Faker::Lorem.paragraph }
    image_filename 'http://placekitten.com/600/400'
    published_at Time.now - 1.day
  end

  factory :invalid_work, parent: :work do
    title nil
  end

  factory :draft_work, parent: :work do
    published_at nil
  end

end
