require 'rails_helper'

describe 'the add a note process' do
  it "adds a new note" do
    scale = FactoryGirl.create(:scale)
    visit scales_path
    click_link "Something"
    click_link "Add some notes"
    fill_in "Frequencies", :with => "1200"
    click_on "Add Notes"
    expect(page).to have_content "1200"
  end

  it "gives error when no fields are filled out" do
    scale = FactoryGirl.create(:scale)
    visit scales_path
    click_link "Something"
    click_link "Add some notes"
    click_on "Add Notes"
    expect(page).to have_content "You must enter at least one frequency"
  end
end
