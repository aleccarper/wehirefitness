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
    zip '80111'
    city 'Greenwood Village'
    state 'Colorado'
    published false
    stripe_customer_id 'cus_6wNSe1hvyfHkLd'
  end
end
