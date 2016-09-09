require 'rails_helper'

describe Scale do
  it { should have_many :notes }
  it { should validate_presence_of :name }
end
