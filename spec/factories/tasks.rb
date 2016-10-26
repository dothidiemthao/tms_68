FactoryGirl.define do
  factory :task do |f|
    f.name {Faker::Name.name}
    f.description {Faker::Hacker.say_something_smart}
  end
end
