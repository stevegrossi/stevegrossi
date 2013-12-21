require 'faker'

FactoryGirl.define do

  factory :book do
    title        { Faker::Lorem.sentence(6) }
    publisher    { Faker::Company.name }
    pub_year     { Time.now.year - 1 }
    start_date   { Time.now - 1.month }
    end_date     { Time.now - 1.week }
    after :build do |book|
      book.authors << build(:author)
    end
  end

  factory :book_without_author, parent: Book do
    after :build do |book|
      book.authors = []
    end
  end

  factory :book_with_two_authors, parent: Book do
    after :build do |book|
      book.authors << build(:author)
    end
  end

  factory :unread_book, parent: Book do
    end_date nil
  end

end
