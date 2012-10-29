require 'faker'

FactoryGirl.define do
  factory :author do
    fname { Faker::Name.first_name }
    lname { Faker::Name.last_name }
  end
end
