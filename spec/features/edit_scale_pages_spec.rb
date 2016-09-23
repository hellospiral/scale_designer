require 'rails_helper'

describe 'the edit a scale process' do
  it "edits a scale", js: true do
    user = User.create(email: "matt@matt.com", password: "password")
    scale = FactoryGirl.create(:scale, user_id: user.id)
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_on "Log in"
    click_on "Something"
    click_link "Edit Scale Name"
    fill_in "Name", :with => "Something cool"
    click_on "Update Scale"
    expect(page).to have_content "Something cool"
  end

  it "gives error when no fields are filled out" do
    user = User.create(email: "matt@matt.com", password: "password")
    scale = FactoryGirl.create(:scale, user_id: user.id)
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_on "Log in"
    click_on "Something"
    click_link "Edit Scale Name"
    fill_in "Name", :with => ""
    click_on "Update Scale"
    expect(page).to have_content "errors"
  end
end
