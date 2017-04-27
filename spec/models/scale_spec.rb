require 'rails_helper'

describe Scale do

  it { should have_many :notes }
  it { should validate_presence_of :name }
  it {should belong_to :user }

  let(:scale) { FactoryGirl.create(:scale) }
  let(:note) { note = FactoryGirl.create(:note, scale: scale) }

  describe '#create_note' do

    it 'adds a new note to the scale' do
      params = { "note_id" => note.id, "third_type" => "Major (5/4)",  "scale_id" => scale.id }
      scale.create_note(params)
      expect(scale.notes.count).to eq(2)
    end

    it 'creates a new note with the correct frequency' do
      params = { "note_id" => note.id, "octave" => true,  "scale_id" => scale.id }
      scale.create_note(params)
      expect(scale.notes.last.frequency / note.frequency).to eq(2)
    end
  end
end
