require 'rails_helper'
require 'spec_helper'

describe 'the edit a note process' do
  it 'edits a note', js: true do
    user = User.create(email: "matt@matt.com", password: "password")
    scale = FactoryGirl.create(:scale, user_id: user.id)
    note = FactoryGirl.create(:note, scale_id: scale.id)
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_on "Log in"
    click_on "Something"
    click_on "Edit"
    fill_in "Frequency", :with => "1300"
    click_on "Update Note"
    expect(page).to have_content "1300"
  end

  it "gives an error if a field is blank" do
    user = User.create(email: "matt@matt.com", password: "password")
    scale = FactoryGirl.create(:scale, user_id: user.id)
    note = FactoryGirl.create(:note, scale_id: scale.id)
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_on "Log in"
    click_on "Something"
    visit edit_scale_note_path(scale, note)
    fill_in "Frequency", :with => ""
    click_on "Update Note"
    expect(page).to have_content 'errors'
  end
end
