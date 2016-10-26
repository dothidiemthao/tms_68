FactoryGirl.define do
  factory :subject do
    name {Faker::Name.name}
    description {Faker::Hacker.say_something_smart}
    tasks {[FactoryGirl.create(:task)]}
  end
end
