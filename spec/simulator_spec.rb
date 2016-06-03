require 'spec_helper'

RSpec.describe ToyRobot::Simulator do
  let(:robot) { ToyRobot::Robot.new }
  let(:table) { ToyRobot::Table.new(size: 5) }

  subject { described_class.new(robot: robot, table: table) }

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
    it 'move robot to the North by 1 step' do
      subject.place(0, 1, :north)

      subject.move

      expect(subject.report).to eq [1, 1, :north]
    end

    it 'move robot to the East by 1 step' do
      subject.place(0, 0, :east)

      subject.move

      expect(subject.report).to eq [0, 1, :east]
    end

    it 'move robot to the South by 1 step' do
      subject.place(1, 0, :south)

      subject.move

      expect(subject.report).to eq [0, 0, :south]
    end

    it 'move robot to the West by 1 step' do
      subject.place(0, 1, :west)

      subject.move

      expect(subject.report).to eq [0, 0, :west]
    end

    it 'raise when robot moving out of the table' do
      subject.place(0, 4, :east)

      expect{ subject.move }.to raise_error(
        ToyRobot::ProhibitedStep)
    end

    it 'not execute when robot not placed' do
      expect{ subject.move }.to raise_error(
        ToyRobot::RobotNotPlaced)
    end
  end

  describe '#left' do
    context 'it faced north' do
      before { subject.place(0, 0, :north) }

      it 'runs once and robot rotated at 90 degree' do subject.left

      expect(subject.report).to eq [0, 0, :west]
      end

      it 'runs twice and robot rotated at 180 degree' do
        subject.left
        subject.left

        expect(subject.report).to eq [0, 0, :south]
      end
    end
 
    it 'not execute when robot not placed' do
      expect{ subject.left }.to raise_error(
        ToyRobot::RobotNotPlaced)
    end
  end

  describe '#right' do
    context 'it faced north' do
      before { subject.place(0, 0, :north) }

      it 'runs once and robot rotated at 90 degree' do
        subject.right

        expect(subject.report).to eq [0, 0, :east]
      end

      it 'runs twice and robot rotated at 180 degree' do
        subject.right
        subject.right

        expect(subject.report).to eq [0, 0, :south]
      end
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
