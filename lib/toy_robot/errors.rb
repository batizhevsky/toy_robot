module ToyRobot
  Error = Class.new(StandardError)
  RobotNotPlaced = Class.new(Error)
  OutOfTable = Class.new(Error)
  ProhibitedStep = Class.new(Error)
  UnknownDirection = Class.new(Error)
end
