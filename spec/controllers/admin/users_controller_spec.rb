require "rails_helper"

RSpec.describe Admin::UsersController, type: :controller do
  let(:admin) {FactoryGirl.create(:user, :admin)}
  before do
    @user_valid = {name: "Test valid", email: "testvalid@gmail.com",
      password: "123456", password_confirmation: "123456"}
    @user_invalid = {name: "", email: "test", password: "123456",
      password_confirmation: "123456"}
    sign_in admin
  end

  context "GET #index" do
    it "should render index" do
      get :index
      expect(response).to render_template "index"
    end
  end

  context "GET #new" do
    let!(:user) {FactoryGirl.create(:user)}
    it "should render new" do
      get :new, id: user.id
      expect(response).to render_template "new"
    end
  end

  context "POST #create" do
    it "add user after create user valid" do
      count = User.all.count
      post :create, user: @user_valid
      expect(User.all.count).to eq (count + 1)
    end

    it "not add user after create user invalid" do
      count = User.all.count
      post :create, user: @user_invalid
      expect(User.all.count).to eq (count)
    end

    it "should redirect to admin_users_path after create" do
      post :create, user: @user_valid
      expect(response).to redirect_to(admin_users_path)
    end
  end

  context "GET #edit" do
    let!(:user) {FactoryGirl.create(:user)}
    it "should render edit" do
      get :edit, id: user.id
      expect(response).to render_template "edit"
    end
  end

  context "PATCH #update" do
    let!(:user) {FactoryGirl.create(:user)}
    it "should update user valid" do
      patch :update, id: user.id, user: {name: "Update Valid"}
      user.reload
      expect(user.name).to eq "Update Valid"
    end

    it "should update user invalid" do
      user_before = user
      patch :update, id: user.id, user: {name: ""}
      user.reload
      expect(user).to eq (user_before)
    end

    it "should redirect to admin_users_path after update valid" do
      patch :update, id: user.id, user: {name: "Update Valid"}
      expect(response).to redirect_to(admin_users_path)
    end

    it "should render edit after update invalid" do
      patch :update, id: user.id, user: {name: ""}
      expect(response).to render_template "edit"
    end
  end

  context "DELETE #destroy" do
    let!(:user) {FactoryGirl.create(:user)}
    it "should delete user after delete success" do
      count = User.all.count
      delete :destroy, id: user.id
      expect(User.all.count).to eq(count - 1)
    end

    it "should redirect to admin_users_path after delete" do
      delete :destroy, id: user.id
      expect(response).to redirect_to(admin_users_path)
    end

    it "should after delete fail" do
      user.destroy
      expect do
        delete :destroy, id: user.id
      end.to raise_exception ActiveRecord::RecordNotFound
    end
  end
end
