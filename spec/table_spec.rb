require 'spec_helper'

RSpec.describe ToyRobot::Table do
  let(:table_size) { 5 } 

  subject { described_class.new(size: table_size) }

  describe '#can_placed?' do
    it 'true when coords on the table' do
      placed = subject.can_placed?(1,2)
      expect(placed).to be true
    end

    it 'false when oords out of the table' do
      placed = subject.can_placed?(6,2)
      expect(placed).to be false
    end

    it 'false when coords is negative' do
      placed = subject.can_placed?(6,2)
      expect(placed).to be false
    end
  end
end
