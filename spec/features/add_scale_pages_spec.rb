require 'rails_helper'

describe "the add a scale process", js: true do
  it "adds a new scale" do
    visit scales_path
    click_link 'Add a Scale'
    fill_in 'Name', :with => 'First Scale'
    click_on 'Create Scale'
    expect(page).to have_content 'First Scale'
  end

  it "gives error when no name is entered", js: true do
    visit new_scale_path
    click_on 'Create Scale'
    expect(page).to have_content 'errors'
  end
end
