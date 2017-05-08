class Note < ActiveRecord::Base
  attr_accessor :transposition
  belongs_to :scale
  has_closure_tree order: 'frequency'

  validates :frequency, :presence => true

  after_create :increment_note_count
  after_destroy :decrement_note_count

  def transpose(params)
    if params[:transposition] == 'up_octave'
      self.transpose_up_octave
    elsif params[:transposition] == 'down_octave'
      self.transpose_down_octave
    end
  end

  def transpose_up_octave
    self.frequency = self.frequency * 2
    self.save!
  end

  def transpose_down_octave
    self.frequency = self.frequency / 2
    self.save!
  end

  def relative_name
    # MC_REVISIT: don't hard code this
    if self.parent
      if self.name == '8/5 major third down' && self.frequency > self.parent.frequency
        '8/5 minor sixth up'
      elsif self.name == '4/3 perfect fifth down' && self.frequency > self.parent.frequency
        '4/3 perfect fourth up'
      elsif self.name == '3/2 perfect fifth' && self.frequency < self.parent.frequency
        '3/2 perfect fourth down'
      else
        self.name
      end
    else
      self.name
    end
  end

  private

  def increment_note_count
    self.scale.notes_count += 1
    self.scale.save!
  end

  def decrement_note_count
    self.scale.notes_count -= 1
    self.scale.save!
  end
end
