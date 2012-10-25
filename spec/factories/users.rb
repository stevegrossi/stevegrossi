require 'faker'

FactoryGirl.define do
  factory :user do
    username Faker::Name.first_name
    password 'secret'
  end
end
