# Represents a player in the game
class Player
  attr_reader :name, :marker

  def initialize(name, marker)
    @name = name
    @marker = marker
  end
end


# Represents a single square on the board
class Square
  attr_reader :state

  def initialize
    @state = :empty
  end

  def empty?
    @state == :empty
  end

  def update_state(marker)
    @state = marker
  end
end


# Represents the game board
class Board
  def initialize(size)
    @size = size
    @board = Array.new(size) { Array.new(size) { Square.new } }
  end

  # Check if position is within board boundaries
  def valid_position?(row, col)
    row.between?(0, @size - 1) && col.between?(0, @size - 1)
  end

  # Safely get square at position
  def square_at(row, col)
    return nil unless valid_position?(row, col)
    @board[row][col]
  end

  # Update square if empty
  def update_square(row, col, marker)
    square = square_at(row, col)
    return false unless square&.empty?

    square.update_state(marker)
    true
  end

  # Check if board is completely filled
  def full?
    @board.flatten.none?(&:empty?)
  end

  # Display board to console
  def display
    puts
    @board.each do |row|
      puts row.map { |sq| sq.state == :empty ? "_" : sq.state }.join(" ")
    end
    puts
  end

  # Used for win checks
  def states
    @board.map { |row| row.map(&:state) }
  end
end


# Controls game flow
class Game
  def initialize(player1, player2, size)
    @players = [player1, player2]
    @board = Board.new(size)
    @turn_index = 0
    @game_over = false
  end

  # Current player
  def current_player
    @players[@turn_index]
  end

  # Main game loop
  def start
    puts "🎮 Tic-Tac-Toe Started!"
    puts "Enter moves as: row,col (example: 0,2)"

    until @game_over
      @board.display
      player = current_player
      puts "#{player.name}'s turn (#{player.marker})"

      print "Your move: "
      input = gets.chomp

      unless input.match?(/^\d+,\d+$/)
        puts "❌ Invalid input format"
        next
      end

      row, col = input.split(",").map(&:to_i)
      result = play(player, [row, col])

      puts result if result.is_a?(String)
    end
  end

  # Process a move
  def play(player, move)
    return "❌ It's not your turn, #{player.name}" unless player == current_player

    row, col = move
    success = @board.update_square(row, col, player.marker)

    return "❌ Invalid or already occupied square" unless success

    if winner?(player)
      @board.display
      puts "🏆 #{player.name} wins!"
      @game_over = true
      return
    end

    if @board.full?
      @board.display
      puts "🤝 It's a draw!"
      @game_over = true
      return
    end

    switch_turn
  end

  # Switch turns between players
  def switch_turn
    @turn_index = (@turn_index + 1) % 2
  end

  # Check all win conditions
  def winner?(player)
    marker = player.marker
    states = @board.states
    size = states.size

    # Rows
    return true if states.any? { |row| row.all?(marker) }

    # Columns
    (0...size).each do |col|
      return true if states.all? { |row| row[col] == marker }
    end

    # Diagonals
    return true if (0...size).all? { |i| states[i][i] == marker }
    return true if (0...size).all? { |i| states[i][size - 1 - i] == marker }

    false
  end
end


# ---- Game Start ----

player1 = Player.new("Smit", :X)
player2 = Player.new("Arpi", :O)

game = Game.new(player1, player2, 3)
game.start
