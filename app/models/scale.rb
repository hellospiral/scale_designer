class Scale < ActiveRecord::Base
  has_many :notes
  belongs_to :user, optional: true
  validates :name, :presence => true
end
