FactoryGirl.define do
  factory :task do
    name {Faker::Name.name}
    description {Faker::Hacker.say_something_smart}
  end
end
