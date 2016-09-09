require 'rails_helper'

describe "the delete a scale process" do
  it "deletes a scale" do
    scale = Scale.create(:name => "abcdefg87654321")
    visit scales_path
    click_link 'abcdefg87654321'
    click_link 'Delete'
    expect(page).to have_no_content 'abcdefg87654321'
  end
end
