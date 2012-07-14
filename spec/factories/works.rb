require 'faker'

FactoryGirl.define do
  factory :work do
    title { Faker::Lorem.sentence }
    about { Faker::Lorem.paragraph }
    image_filename 'http://placekitten.com/600/400'
  end
end