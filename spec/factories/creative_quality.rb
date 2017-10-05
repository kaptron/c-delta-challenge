FactoryGirl.define do
  factory :creative_quality do
    name { Faker::Company.buzzword }
    description { Faker::Company.bs.titleize }
    color { Faker::Color.unique.color_name }
  end
end
