module ToyRobot
  class CLIAdaptor
    extend Forwardable

    COMMANDS = {
      /\APLACE\s(\d+),(\d+),(.+)\z/ => :place,
      /\AMOVE\z/ => :move,
      /\ALEFT\z/ => :left,
      /\ARIGHT\z/ => :right,
      /\AREPORT\z/ => :report
    }.freeze

    def initialize(simulator: Simulator.new, debug: false)
      @simulator = simulator
      @debug = debug
    end

    def handle(input)
      command = input.strip.upcase
      COMMANDS.each do |regexp, method|
        result = command.match(regexp)
        next unless result

        return send(method, *result.captures)
      end

      puts "Unknown command #{ command }" if @debug
    rescue => e
      puts e if @debug
    end

    private

    def_delegators :@simulator, :move, :left, :right

    def place(x, y, f)
      @simulator.place(x.to_i, y.to_i, f.downcase.to_sym)
    end

    def report
      output = @simulator.report.join(',').upcase
      puts "Output: #{ output }"
    end
  end
end
