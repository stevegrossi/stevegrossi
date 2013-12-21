require 'faker'

FactoryGirl.define do
  factory :post do
    title         { Faker::Lorem.sentence(6) }
    idea          { Faker::Lorem.sentence }
    content       { Faker::Lorem.paragraphs.join('\n\n') }
    published_at  { Time.now - 1.day }
  end
  factory :link_post, parent: :post do
    link_url { Faker::Internet.url }
  end
  factory :book_post, parent: :post do
    title nil
    book { create(:book) }
  end
  factory :invalid_post, parent: :post do
    title nil
  end
  factory :draft_post, parent: :post do
    published_at nil
  end
end
