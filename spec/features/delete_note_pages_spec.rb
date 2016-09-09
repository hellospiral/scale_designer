require 'rails_helper'

describe 'the delete a note process' do
  it 'deletes a note' do
    scale = Scale.create(:name => "Something")
    note = Note.create(:frequency => "1234567", :scale_id => scale.id)
    visit scale_path(scale)
    click_on "Delete"
    expect(page).to have_no_content "1234567"
  end
end
