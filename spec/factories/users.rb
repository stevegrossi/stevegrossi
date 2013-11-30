require 'faker'

FactoryGirl.define do
  factory :user do
    username Faker::Name.first_name
    password test_password
    password_confirmation test_password
  end
end
