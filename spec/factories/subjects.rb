FactoryGirl.define do
  factory :subject do |f|
    f.name {Faker::Name.name}
    f.description {Faker::Hacker.say_something_smart}
  end
end
