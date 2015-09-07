FactoryGirl.define do

  factory :post do
    title         { Faker::Lorem.sentence(6) }
    idea          { Faker::Lorem.sentence }
    content       { Faker::Lorem.paragraphs.join('\n\n') }
    published_at  { 1.day.ago }

    trait :book_post do
      title nil
      book { create(:book) }
    end

    trait :draft do
      published_at nil
    end
  end
end
