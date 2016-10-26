require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) {FactoryGirl.create :user}
  subject {user}

  describe "validates" do
    context "create is valid" do
      it {is_expected.to be_valid}
    end

    context "name is not valid" do
      before {subject.name = ""}
      it {is_expected.not_to be_valid}
    end

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

    context "file avatar upload is not valid" do
      before {subject.avatar_url =
        File.open(Rails.root.join("spec/uploads/avatar.ico"))}
      it {is_expected.not_to be_valid}
    end
  end

  describe "scope" do
    let(:user_one) {FactoryGirl.create :user}
    let(:user_two) {FactoryGirl.create :user}
    # it "order by descending create_at" do
    #   expect(User.recent).to eq [user_two, user_one]
    # end
  end
end
