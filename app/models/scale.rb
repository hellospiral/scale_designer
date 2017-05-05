class Scale < ActiveRecord::Base
  has_many :notes
  belongs_to :user, optional: true
  scope :active, -> { where("user_id IS NOT NULL") }
  after_create :set_note_count
  after_create :create_starter_note


  def create_third(params, note)
    if params['third_type'] == 'Septimal minor (7/6)'
      return self.notes.create(frequency: note.frequency * 1.166666667)
    elsif params['third_type'] == 'Major (5/4)'
      return self.notes.create(frequency: note.frequency * 1.25)
    elsif params['third_type'] == 'Minor (6/5)'
      return self.notes.create(frequency: note.frequency * 1.2)
    end
  end

  def create_fifth(params, note)
    return self.notes.create(frequency: note.frequency * 1.5)
  end

  def create_seventh(params, note)
    if params['seventh_type'] == 'Major (15/8)'
      return self.notes.create(frequency: note.frequency * 1.875)
    elsif params['seventh_type'] == 'Minor (9/5)'
      return self.notes.create(frequency: note.frequency * 1.8)
    elsif params['seventh_type'] == 'Pythagorean minor (16/9)'
      return self.notes.create(frequency: note.frequency * 1.777777778)
    elsif params['seventh_type'] == 'Harmonic minor (7/4)'
      return self.notes.create(frequency: note.frequency * 1.75)
    end
  end

  def create_octave(params, note)
    return self.notes.create(frequency: note.frequency * 2)
  end

  def parse_frequencies(params)
    notes_array = params[:frequencies].split(',')
    notes_array.each do |note|
      note.strip
      self.notes.create(frequency: note)
    end
  end

  def create_note(params)
    if params['note_id']
      note = self.notes.find(params['note_id'])
    end
    if params['third_type']
      child = self.create_third(params, note)
      note.add_child child
    elsif params['fifth']
      child = self.create_fifth(params, note)
      note.add_child child
    elsif params['seventh_type']
      child = self.create_seventh(params, note)
      note.add_child child
    elsif params['octave']
      child = self.create_octave(params, note)
      note.add_child child
    else
      self.parse_frequencies(params)
    end
  end

  private

  def create_starter_note
    self.notes.create(frequency: 150)
  end

  def set_note_count
    self.notes_count = 0
    self.save!
  end
end
