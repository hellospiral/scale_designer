class Note < ActiveRecord::Base
  belongs_to :scale

  validates :frequency, :presence => true
end
