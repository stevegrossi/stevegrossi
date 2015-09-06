require "faker"

FactoryGirl.define do
  factory :redirect do
    from { Faker::Lorem.words(1).first.downcase }
    to { "http://#{Faker::Internet.domain_name}" }
  end

end
