FactoryGirl.define do
  factory :coupon do
    code Faker::Address.zip
    uses 0
    max_uses 0
    percent_off 50
  end
end
