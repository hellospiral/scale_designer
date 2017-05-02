class Scale < ActiveRecord::Base
  has_many :notes
  belongs_to :user, optional: true
  # validates :name, :presence => true

  def create_third(params, note)
    if params['third_type'] == 'Septimal minor (7/6)'
      self.notes.create(frequency: note.frequency * 1.166666667)
    elsif params['third_type'] == 'Major (5/4)'
      self.notes.create(frequency: note.frequency * 1.25)
    elsif params['third_type'] == 'Minor (6/5)'
      self.notes.create(frequency: note.frequency * 1.2)
    end
  end

  def create_fifth(params, note)
    self.notes.create(frequency: note.frequency * 1.5)
  end

  def create_seventh(params, note)
    if params['seventh_type'] == 'Major (15/8)'
      self.notes.create(frequency: note.frequency * 1.875)
    elsif params['seventh_type'] == 'Minor (9/5)'
      self.notes.create(frequency: note.frequency * 1.8)
    elsif params['seventh_type'] == 'Pythagorean minor (16/9)'
      self.notes.create(frequency: note.frequency * 1.777777778)
    elsif params['seventh_type'] == 'Harmonic minor (7/4)'
      self.notes.create(frequency: note.frequency * 1.75)
    end
  end

  def create_octave(params, note)
    self.notes.create(frequency: note.frequency * 2)
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
      self.create_third(params, note)
    elsif params['fifth']
      self.create_fifth(params, note)
    elsif params['seventh_type']
      self.create_seventh(params, note)
    elsif params['octave']
      self.create_octave(params, note)
    else
      self.parse_frequencies(params)
    end
  end
end
