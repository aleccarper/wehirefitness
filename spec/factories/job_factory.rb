FactoryGirl.define do
  factory :job do
    title Faker::Name.name
    company_email { Faker::Internet.email }
    category 1
    description Faker::Lorem.sentence
    how_to_apply Faker::Lorem.sentence
    company_description Faker::Lorem.sentence
    company_name Faker::Company.name
    company_url Faker::Internet.url
    zip Faker::Address.zip
    city Faker::Address.city
    state Faker::Address.state
  end
end
