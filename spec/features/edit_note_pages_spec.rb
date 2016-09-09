require 'rails_helper'

describe 'the edit a note process' do
  it 'edits a note' do
    scale = Scale.create(:name => "Something")
    note = Note.create(:frequency => "1200", :scale_id => scale.id)
    visit edit_scale_note_path(scale, note)
    fill_in "Frequency", :with => "1300"
    click_on "Update Note"
    expect(page).to have_content "1300"
  end

  it "gives an error if a field is blank" do
    scale = Scale.create(:name => "Something")
    note = Note.create(:frequency => "1200", :scale_id => scale.id)
    visit edit_scale_note_path(scale, note)
    fill_in "Frequency", :with => ""
    click_on "Update Note"
    expect(page).to have_content 'errors'
  end
end
