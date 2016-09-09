require 'rails_helper'

describe Note do
  it { should validate_presence_of :frequency }
  it { should belong_to :scale }
end
