FactoryGirl.define do

  factory :redirect do
    from { Faker::Lorem.word.downcase }
    to { Faker::Internet.url(Faker::Internet.domain_name, nil) }
  end
end
