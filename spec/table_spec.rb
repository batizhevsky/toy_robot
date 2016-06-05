require 'spec_helper'

RSpec.describe ToyRobot::Table do
  let(:table_size) { 5 }

  subject { described_class.new(0, 0, size: table_size) }

  describe 'initialize' do
    specify 'coords out of table raise error' do
      expect{ described_class.new(4, 6) }.to raise_error(
        ToyRobot::OutOfTable)
    end

    specify 'get normal coords' do
      expect(described_class.new(4, 4)).to be_kind_of(described_class)
    end
  end

  describe '#move_to' do
    subject { described_class.new(1, 1) }

    it 'move robot to the North by 1 step' do
      subject.move_to(:north)

      expect(subject.current_position).to eq [2, 1]
    end

    it 'move robot to the East by 1 step' do
      subject.move_to(:east)

      expect(subject.current_position).to eq [1, 2]
    end

    it 'move robot to the South by 1 step' do
      subject.move_to(:south)

      expect(subject.current_position).to eq [0, 1]
    end

    it 'move robot to the West by 1 step' do
      subject.move_to(:west)

      expect(subject.current_position).to eq [1, 0]
    end

    it 'raise when robot moving out of the table' do
      subject = described_class.new(0, 0)

      expect{ subject.move_to(:west) }.to raise_error(
        ToyRobot::OutOfTable)
    end
  end
end
