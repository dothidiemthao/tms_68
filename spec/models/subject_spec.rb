require "rails_helper"

RSpec.describe Subject, type: :model do
  let(:subject) {FactoryGirl.create(:subject)}

  describe "associations" do
    it {expect have_many :course_subjects}
    it {expect have_many :courses}
    it {expect have_many :tasks}
    it {expect have_many :user_subjects}
    it {expect have_many :users}
    it {should accept_nested_attributes_for :tasks}
  end

  describe "validates" do
    context "create is valid" do
      it {is_expected.to be_valid}
    end

    it {expect validate_presence_of :name}
    it {expect validate_presence_of :description}

    context "description is short" do
      before {subject.description = Faker::Lorem.characters(9)}
      it {is_expected.not_to be_valid}
    end

    context "not have any tasks" do
      before {subject.task_ids = nil}
      it {is_expected.not_to be_valid}
    end
  end

  describe "inprogress courses", :private do
    context "course is not started" do
      it {expect(subject.is_inprogess?).to be_falsey}
    end

    context "course is started" do
      let(:subject) {
        FactoryGirl.create :subject,
          courses: [FactoryGirl.create(:course)]
      }
      it {expect(subject.is_inprogess?).to be_truthy}
    end
  end
end
