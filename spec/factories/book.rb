FactoryGirl.define do

  factory :book do
    title        { Faker::Lorem.sentence(6) }
    publisher    { Faker::Company.name }
    pub_year     { Time.current.year - 1 }
    start_date   { 1.month.ago }
    end_date     { 1.week.ago }
    authors      { build_list(:author, 1) }
  end

  factory :book_without_author, parent: Book do
    authors []
  end

  factory :book_with_two_authors, parent: Book do
    authors { build_list(:author, 2) }
  end

  factory :unread_book, parent: Book do
    end_date nil
  end
end
