class Scale < ActiveRecord::Base
  has_many :notes
  belongs_to :user, optional: true
  scope :active, -> { where("user_id IS NOT NULL") }
  after_create :set_note_count
  after_create :create_starter_note


  def create_third(params, note)
    if params['third_type'] == 'Septimal minor (7/6)'
      return self.notes.create(frequency: note.frequency * 1.166666667, name: '7/6 minor third')
    elsif params['third_type'] == 'Major (5/4)'
      return self.notes.create(frequency: note.frequency * 1.25, name: '5/4 major third')
    elsif params['third_type'] == 'Minor (6/5)'
      return self.notes.create(frequency: note.frequency * 1.2, name: '6/5 minor third')
    end
  end

  def create_fifth(params, note)
    return self.notes.create(frequency: note.frequency * 1.5, name: '3/2 perfect fifth')
  end

  def create_seventh(params, note)
    if params['seventh_type'] == 'Major (15/8)'
      return self.notes.create(frequency: note.frequency * 1.875, name: '15/8 major seventh')
    elsif params['seventh_type'] == 'Minor (9/5)'
      return self.notes.create(frequency: note.frequency * 1.8, name: '9/5 minor seventh')
    elsif params['seventh_type'] == 'Pythagorean minor (16/9)'
      return self.notes.create(frequency: note.frequency * 1.777777778, name: '16/9 minor seventh')
    elsif params['seventh_type'] == 'Harmonic minor (7/4)'
      return self.notes.create(frequency: note.frequency * 1.75, name: '7/4 minor seventh')
    end
  end

  def create_octave(params, note)
    return self.notes.create(frequency: note.frequency * 2, name: '2/1 octave')
  end

  def create_fourth(params, note)
    if params['fourth_type'] == 'Perfect (4/3)'
      return self.notes.create(frequency: note.frequency * 1.333333333, name: '4/3 perfect fourth')
    elsif params['fourth_type'] == 'Harmonic Tritone (11/8)'
      return self.notes.create(frequency: note.frequency * 1.375, name: '11/8 harmonic tritone')
    elsif params['fourth_type'] == 'Five-Limit Tritone (45/32)'
      return self.notes.create(frequency: note.frequency * 1.40625, name: '45/32 five-limit tritone')
    end
  end

  def create_fifth_below(params, note)
    return self.notes.create(frequency: note.frequency * 0.666667, name: '4/3 perfect fifth down')
  end

  def create_third_below(params, note)
    return self.notes.create(frequency: note.frequency * 0.8, name: '8/5 major third down')
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
    elsif params['fourth_type']
      child = self.create_fourth(params, note)
      note.add_child child
    elsif params['octave']
      child = self.create_octave(params, note)
      note.add_child child
    elsif params['fifth_below']
      child = self.create_fifth_below(params, note)
      note.add_child child
    elsif params['major_third_below']
      child = self.create_third_below(params, note)
      note.add_child child
    else
      self.parse_frequencies(params)
    end
  end

  private

  def create_starter_note
    self.notes.create(frequency: 150, name: '1/1 root')
  end

  def set_note_count
    self.notes_count = 0
    self.save!
  end
end
