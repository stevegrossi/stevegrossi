FactoryGirl.define do

  factory :book do
    title        { Faker::Lorem.sentence(6) }
    publisher    { Faker::Company.name }
    pub_year     { Time.current.year - 1 }
    start_date   { 1.month.ago }
    end_date     { 1.week.ago }
    authors      { build_list(:author, 1) }

    trait :without_author do
      authors []
    end

    trait :with_two_authors do
      authors { build_list(:author, 2) }
    end

    trait :unread do
      end_date nil
    end
  end
end
