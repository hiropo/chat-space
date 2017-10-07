FactoryGirl.define do

  pass = Faker::Number.number(10)

  factory :user do
    name                   Faker::Name.name
    email                  Faker::Internet.email
    password               pass
    password_confirmation  pass
  end

end