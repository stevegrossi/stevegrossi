FactoryGirl.define do

  factory :page do
    title { Faker::Lorem.words(1).first.capitalize }
    permalink { title.try(:downcase) }
    content { Faker::Lorem.paragraphs.join('\n\n') }
    description { Faker::Lorem.sentence }
  end
end
