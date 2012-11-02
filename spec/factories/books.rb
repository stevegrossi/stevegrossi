require 'faker'

FactoryGirl.define do

  factory :book do
    title        { Faker::Lorem.sentence(6) }
    publisher    { Faker::Company.name }
    pub_year     { Time.now.year - 1 }
    thoughts     { Faker::Lorem.paragraphs.join('\n\n') }
    published_at { Time.now - 1.day }
    after :build do |book|
      book.authors << FactoryGirl.build(:author)
    end
  end

  factory :book_without_author, parent: Book do
    after :build do |book|
      book.authors = []
    end
  end

  factory :book_with_two_authors, parent: Book do
    after :build do |book|
      book.authors << FactoryGirl.build(:author)
    end
  end

  factory :draft_book, parent: Book do
    published_at nil
  end

end
