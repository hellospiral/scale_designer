class Note < ActiveRecord::Base
  belongs_to :scale
  attr_accessor :transposition

  validates :frequency, :presence => true

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
end
