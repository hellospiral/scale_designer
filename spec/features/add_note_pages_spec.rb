require 'rails_helper'

describe 'the add a note process' do
  it "adds a new note" do
    scale = FactoryGirl.create(:scale)
    visit scales_path
    click_link "Something"
    click_link "Add a note"
    fill_in "Frequency", :with => "1200"
    click_on "Create Note"
    expect(page).to have_content "1200"
  end

  it "gives error when no fields are filled out" do
    scale = FactoryGirl.create(:scale)
    visit scales_path
    click_link "Something"
    click_link "Add a note"
    click_on "Create Note"
    expect(page).to have_content "errors"
  end
end
