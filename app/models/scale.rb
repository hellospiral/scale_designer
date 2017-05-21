class Scale < ActiveRecord::Base
  has_many :notes
  belongs_to :user, optional: true
  scope :active, -> { where("user_id IS NOT NULL") }
  after_create :set_note_count
  after_create :create_starter_note

  def create_second(params, note)
    if params['second_type'] == 'Minor 5-limit half-step (25/24)'
      return self.notes.create(frequency: note.frequency * 1.04166667, name: '25/24 (Minor 5-limit half-step)')
    elsif params['second_type'] == 'Major five-limit half-step (16/15)'
      return self.notes.create(frequency: note.frequency * 1.06666667, name: '16/15 (Major five-limit half-step)')
    elsif params['second_type'] == 'Minor whole tone (10/9)'
      return self.notes.create(frequency: note.frequency * 1.11111111, name: '10/9 (Minor whole tone)')
    elsif params['second_type'] == 'Major whole tone (9/8)'
      return self.notes.create(frequency: note.frequency * 1.125, name: '9/8 (Major whole tone)')
    end
  end

  def create_third(params, note)
    if params['third_type'] == 'Septimal minor (7/6)'
      return self.notes.create(frequency: note.frequency * 1.166666667, name: '7/6 minor third')
    elsif params['third_type'] == '5-limit major (5/4)'
      return self.notes.create(frequency: note.frequency * 1.25, name: '5/4 major third')
    elsif params['third_type'] == '5-limit minor (6/5)'
      return self.notes.create(frequency: note.frequency * 1.2, name: '6/5 5-limit minor third')
    elsif params['third_type'] == 'Undecimal "median" third (11/9)'
      return self.notes.create(frequency: note.frequency * 1.22222222, name: '11/9 undecimal "median" third')
    elsif params['third_type'] == 'Septimal major (9/7)'
      return self.notes.create(frequency: note.frequency * 1.28571428, name: '9/7 septimal major third')
    end
  end

  def create_fifth(params, note)
    if params['fifth_type'] == 'Perfect (3/2)'
      return self.notes.create(frequency: note.frequency * 1.5, name: '3/2 perfect fifth')
    elsif params['fifth_type'] == 'Augmented (25/16)'
      return self.notes.create(frequency: note.frequency * 1.5625, name: '25/16 augmented fifth')
    elsif params['fifth_type'] == 'Diminished (36/25)'
      return self.notes.create(frequency: note.frequency * 1.44, name: '36/25 diminished fifth')
    end
  end

  def create_seventh(params, note)
    if params['seventh_type'] == '5-limit major (15/8)'
      return self.notes.create(frequency: note.frequency * 1.875, name: '15/8 major seventh')
    elsif params['seventh_type'] == '5-limit large minor (9/5)'
      return self.notes.create(frequency: note.frequency * 1.8, name: '9/5 minor seventh')
    elsif params['seventh_type'] == 'Pythagorean small minor (16/9)'
      return self.notes.create(frequency: note.frequency * 1.777777778, name: '16/9 minor seventh')
    elsif params['seventh_type'] == 'Septimal minor (7/4)'
      return self.notes.create(frequency: note.frequency * 1.75, name: '7/4 septimal minor seventh')
    end
  end

  def create_octave(params, note)
    return self.notes.create(frequency: note.frequency * 2, name: '2/1')
  end

  def create_third_harmonic(params, note)
    return self.notes.create(frequency: note.frequency * 1.5, name: '3/2 third harmonic')
  end

  def create_fifth_harmonic(params, note)
    return self.notes.create(frequency: note.frequency * 1.25, name: '5/4 fifth harmonic')
  end

  def create_seventh_harmonic(params, note)
    return self.notes.create(frequency: note.frequency * 1.75, name: '7/4 seventh harmonic')
  end

  def create_eleventh_harmonic(params, note)
    return self.notes.create(frequency: note.frequency * 1.375, name: '11/8 eleventh harmonic')
  end

  def create_thirteenth_harmonic(params, note)
    return self.notes.create(frequency: note.frequency * 1.625, name: '13/8 eleventh harmonic')
  end

  def create_fourth(params, note)
    if params['fourth_type'] == 'Perfect (4/3)'
      return self.notes.create(frequency: note.frequency * 1.333333333, name: '4/3 perfect fourth')
    elsif params['fourth_type'] == 'Harmonic Tritone (11/8)'
      return self.notes.create(frequency: note.frequency * 1.375, name: '11/8 harmonic tritone')
    elsif params['fourth_type'] == 'Five-Limit Tritone (45/32)'
      return self.notes.create(frequency: note.frequency * 1.40625, name: '45/32 five-limit tritone')
    elsif params['fourth_type'] == 'Septimal fourth (21/16)'
      return self.notes.create(frequency: note.frequency * 1.3125, name: '21/16 septimal fourth')
    end
  end

  def create_sixth(params, note)
    if params['sixth_type'] == 'Five-limit minor (8/5)'
      return self.notes.create(frequency: note.frequency * 1.6, name: '8/5 five-limit minor')
    elsif params['sixth_type'] == '5-limit major (5/3)'
      return self.notes.create(frequency: note.frequency * 1.666666667, name: '5/3 5-limit major')
    elsif params['sixth_type'] == 'Undecimal minor (11/7)'
      return self.notes.create(frequency: note.frequency * 1.571428, name: '11/7 undecimal minor sixth')
    elsif params['sixth_type'] == 'Overtone sixth (13/8)'
      return self.notes.create(frequency: note.frequency * 1.625, name: '13/8 overtone sixth')
    elsif params['sixth_type'] == 'Septimal major (12/7)'
      return self.notes.create(frequency: note.frequency * 1.7142857, name: '12/7 septimal major sixth')
    end
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
    elsif params['fifth_type']
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
    elsif params['second_type']
      child = self.create_second(params, note)
      note.add_child child
    elsif params['sixth_type']
      child = self.create_sixth(params, note)
      note.add_child child
    else
      self.parse_frequencies(params)
    end
  end

  def create_harmonic(params)
    if params['note_id']
      note = self.notes.find(params['note_id'])
    end
    if params['octave']
      child = self.create_octave(params, note)
      note.add_child child
    elsif params['third_harmonic']
      child = self.create_third_harmonic(params, note)
      note.add_child child
    elsif params['fifth_harmonic']
      child = self.create_fifth_harmonic(params, note)
      note.add_child child
    elsif params['seventh_harmonic']
      child = self.create_seventh_harmonic(params, note)
      note.add_child child
    elsif params['eleventh_harmonic']
      child = self.create_eleventh_harmonic(params, note)
      note.add_child child
    elsif params['thirteenth_harmonic']
      child = self.create_thirteenth_harmonic(params, note)
      note.add_child child
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
