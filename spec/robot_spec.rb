require 'spec_helper'

RSpec.describe ToyRobot::Robot do
  let(:direction) { :north }

  subject { described_class.new(direction) }

  describe 'initialization' do
    context 'incorrect direction passed' do
      it 'raise error' do
        expect{ described_class.new(:wrong) }.to raise_error(
          ToyRobot::UnknownDirection)
      end
    end

    context 'valid direction passed' do
      it 'create instance' do
        instance = described_class.new(:south)

        expect(instance).to be_a_kind_of(described_class)
      end
    end
  end

  describe '#direction' do
    it 'return direction' do
      expect(subject.direction).to eq direction
    end
  end

  describe '#left' do
    it 'runs once and robot rotated at 90 degree' do
      subject.left

      expect(subject.direction).to eq :west
    end

    it 'runs twice and robot rotated at 180 degree' do
      subject.left
      subject.left

      expect(subject.direction).to eq :south
    end
  end

  describe '#right' do
    it 'runs once and robot rotated at 90 degree' do
      subject.right

      expect(subject.direction).to eq :east
    end

    it 'runs twice and robot rotated at 180 degree' do
      subject.right
      subject.right

      expect(subject.direction).to eq :south
    end
  end
end
