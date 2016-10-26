require "rails_helper"

RSpec.describe User, type: :model do
  let(:user) {FactoryGirl.create :user}
  subject {user}

  describe "associations" do
    it {expect have_many :activities}
    it {expect have_many :user_courses}
    it {expect have_many :courses}
    it {expect have_many :user_subjects}
    it {expect have_many :subjects}
  end

  describe "validates" do
    context "create is valid" do
      it {is_expected.to be_valid}
    end

    it {expect validate_presence_of :name}
    it {expect validate_presence_of :email}
    it {expect validate_presence_of :encrypted_password}

    context "name is too long" do
      before {subject.name = Faker::Lorem.characters(51)}
      it {is_expected.not_to be_valid}
    end

    context "email not valid" do
      before {subject.email = "test"}
      it {is_expected.not_to be_valid}
    end

    context "password is short" do
      before {subject.password = "123", subject.password_confirmation = "123"}
      it {is_expected.not_to be_valid}
    end

    context "password not matching" do
      before {subject.password = "123456",
        subject.password_confirmation = "123123"}
      it {is_expected.not_to be_valid}
    end
  end
end
