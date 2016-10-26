FactoryGirl.define do
  factory :course do
    name {Faker::Name.name}
    description {Faker::Hacker.say_something_smart}
    start_date {Faker::Time.forward(27)}
    end_date {Faker::Time.forward(28)}
    status {Course.statuses[:started]}
    users {[FactoryGirl.create(:user)]}
    subjects {[FactoryGirl.create(:subject)]}
  end
end
