require 'rails_helper'

RSpec.describe "admin/users/index", type: :view do
  let(:admin) {FactoryGirl.create(:user, :admin)}
  let(:user) {FactoryGirl.create(:user)}

  it "should display list user" do
    assign :users, [admin, user]
    render template: "admin/users/index"
    assert_template partial: "admin/users/_user"
    expect(rendered).to include(admin.name)
    expect(rendered).to include(user.name)
  end
end
