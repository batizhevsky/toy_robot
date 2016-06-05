require 'spec_helper'

RSpec.describe ToyRobot::CLIAdaptor do
  let(:simulator) { double('ToyRobot::Simulator') }

  subject { described_class.new(simulator: simulator) }

  describe 'not handle unknown actions' do
    it 'nothing call' do
      expect(simulator).to_not receive(:test)

      subject.handle('TEST')
    end
  end

  describe 'handle MOVE' do
    it 'call move at simulator' do
      expect(simulator).to receive(:move)

      subject.handle('MOVE')
    end
  end

  describe 'handle LEFT' do
    it 'call move at simulator' do
      expect(simulator).to receive(:left)

      subject.handle('LEFT')
    end
  end

  describe 'handle RIGHT' do
    it 'call move at simulator' do
      expect(simulator).to receive(:right)

      subject.handle('RIGHT')
    end
  end

  describe 'handle PLACE' do
    it 'not call place with wrong format' do
      expect(simulator).to_not receive(:place)

      subject.handle('PLACE 10 20 NORTH')
    end

    it 'call place when proper format string' do
      expect(simulator).to receive(:place).with(10, 20, :north)

      subject.handle('PLACE 10,20,NORTH')
    end
  end

  describe 'handle output' do
    it 'not call place with wrong format' do
      expect(simulator).to receive(:report)

      subject.handle('REPORT')
    end
  end
end
