require 'faker'

FactoryGirl.define do
  factory :user do
    username Faker::Name.first_name
    password 'secret'
    password_confirmation 'secret'
  end
end
