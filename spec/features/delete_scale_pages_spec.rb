require 'rails_helper'

describe "the delete a scale process" do
  it "deletes a scale" do
    scale = FactoryGirl.create(:scale)
    visit scales_path
    click_link 'Something'
    click_link 'Delete Scale'
    expect(page).to have_no_content 'abcdefg87654321'
  end
end
