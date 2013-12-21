require 'faker'

FactoryGirl.define do
  factory :user do
    email Faker::Internet.email
    password test_password
    password_confirmation test_password
  end
end
