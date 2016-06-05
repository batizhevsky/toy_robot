require 'spec_helper'

RSpec.describe ToyRobot::Simulator do
  let(:robot) { spy('ToyRobot::Robot') }
  let(:table) { spy('ToyRobot::Table') }

  subject { described_class.new }

  describe '#place' do
    it 'setup simulator' do
      subject.place(0, 1, :north)

      expect(subject.report).to eq [0, 1, :north]
    end

    it 'raise error when placed out of table' do
      expect{ subject.place(5,6, :west) }.to raise_error(
        ToyRobot::OutOfTable)
    end

    it 'raise error when faced to unknown side' do
      expect{ subject.place(4,4, :wrond) }.to raise_error(
        ToyRobot::UnknownDirection)
    end

    it 'move robot when call place second time' do
      subject.place(0, 1, :north)

      subject.place(4, 3, :west)

      expect(subject.report).to eq [4, 3, :west]
    end
  end

  describe '#move' do
    it 'call table to move' do
      allow(subject).to receive(:robot) { robot }
      allow(subject).to receive(:table) { table }

      expect(robot).to receive(:direction) { :south }
      expect(table).to receive(:move_to).with(:south)

      subject.move
    end

    it 'not execute when robot not placed' do
      expect{ subject.move }.to raise_error(
        ToyRobot::RobotNotPlaced)
    end
  end

  describe '#left' do
    it 'turn robot left' do
      allow(subject).to receive(:robot) { robot }
      expect(robot).to receive(:left)

      subject.left
    end

    it 'not execute when robot not placed' do
      expect{ subject.left }.to raise_error(
        ToyRobot::RobotNotPlaced)
    end
  end

  describe '#right' do
    it 'turn robot right' do
      allow(subject).to receive(:robot) { robot }
      expect(robot).to receive(:right)

      subject.right
    end

    it 'not execute when robot not placed' do
      expect{ subject.right }.to raise_error(
        ToyRobot::RobotNotPlaced)
    end
  end

  describe '#output' do
    it 'output current place' do
      subject.place(4, 3, :west)

      expect(subject.report).to eq [4, 3, :west]
    end

    it 'not output if robot not placed' do
      expect{ subject.report }.to raise_error(
        ToyRobot::RobotNotPlaced)
    end
  end
end
