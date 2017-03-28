class Universe
  class Simulation
    attr_accessor :result
    def self.run seed, time
      @@rng = Random.new(seed)

      board = [
        [nil, nil, nil],
        [nil, nil, nil],
        [nil, nil, nil]
      ]

      0.upto(time) do |t|
        board = self.deterministic_move(board)
        break if self.terminal_state? board
      end

      board
    end

    def self.terminal_state? board
      [
        # Horizontal wins
        !board[0][0].nil? && [board[0][0], board[0][1], board[0][2]].uniq.count == 1,
        !board[1][0].nil? && [board[1][0], board[1][1], board[1][2]].uniq.count == 1,
        !board[2][0].nil? && [board[2][0], board[2][1], board[2][2]].uniq.count == 1,

        # Vertical wins
        !board[0][0].nil? && [board[0][0], board[1][0], board[2][0]].uniq.count == 1,
        !board[0][1].nil? && [board[0][1], board[1][1], board[2][1]].uniq.count == 1,
        !board[0][2].nil? && [board[0][2], board[1][2], board[2][2]].uniq.count == 1,

        # Diagonal wins
        !board[0][0].nil? && [board[0][0], board[1][1], board[2][2]].uniq.count == 1,
        !board[2][0].nil? && [board[2][0], board[1][1], board[0][2]].uniq.count == 1
      ].any?
    end

    def self.deterministic_move board
      index_pointer = -1
      unfilled_indices = board.flatten.map { |coordinate| index_pointer += 1; coordinate.nil? ? index_pointer : nil }.compact
      selected_move_index = unfilled_indices[@@rng.rand(unfilled_indices.count)]

      board[selected_move_index % board.count][selected_move_index / board.count] = unfilled_indices.count.even? ? 'X' : 'O'
      board
    end
  end

  class Timeline
    attr_accessor :seed
    class State
      attr_accessor :seed, :time
      class Point
        attr_accessor :seed, :time, :coordinates

        def initialize seed, time, coordinates
          self.seed = seed
          self.time = time
          self.coordinates = coordinates
        end

        def to_s
          Simulation.run(seed, time)
        end
      end

      def initialize seed, time
        self.seed = seed
        self.time = time
      end

      def [] coordinates
        Point.new self.seed, self.time, coordinates
      end

      def to_s
        Simulation.run(seed, time).map { |row| row.map { |col| col.nil? ? '-' : col } }
      end
    end

    def initialize seed
      self.seed = seed
    end

    def [] time_offset
      State.new self.seed, time_offset
    end
  end

  def self.[] seed
    Timeline.new seed
  end
end

god_seed = 2
turn_count = 10
puts Universe[god_seed][turn_count].to_s.map { |row| row.join('  ') }.join("\n")



#puts Universe[2][10][{x: 0, y: 0}]
