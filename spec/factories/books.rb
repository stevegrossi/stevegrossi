require "faker"

FactoryGirl.define do

  factory :book do
    title        { Faker::Lorem.sentence(6) }
    publisher    { Faker::Company.name }
    pub_year     { Time.now.year - 1 }
    start_date   { Time.now - 1.month }
    end_date     { Time.now - 1.week }
    authors      { [build(:author)] }
  end

  factory :book_without_author, parent: Book do
    authors []
  end

  factory :book_with_two_authors, parent: Book do
    authors { [build(:author), build(:author)] }
  end

  factory :unread_book, parent: Book do
    end_date nil
  end

end
