require 'rails_helper'

describe 'the edit a scale process' do
  it "edits a scale" do
    scale = Scale.create(:name => "Something")
    visit scale_path(scale)
    click_link "Edit Scale Name"
    fill_in "Name", :with => "Something cool"
    click_on "Update Scale"
    expect(page).to have_content "Something cool"
  end

  it "gives error when no fields are filled out" do
    scale = Scale.create(:name => "Something")
    visit scale_path(scale)
    click_link "Edit Scale Name"
    fill_in "Name", :with => ""
    click_on "Update Scale"
    expect(page).to have_content "errors"
  end
end
