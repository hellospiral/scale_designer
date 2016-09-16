require 'rails_helper'

describe 'viewing a scale' do
  it 'shows details for a particular scale' do
    scale = FactoryGirl.create(:scale)
    visit scales_path
    click_link("Something")
    expect(page).to have_content "Something"
    expect(page).to have_content "Edit"
    expect(page).to have_content "Delete"
  end
end
