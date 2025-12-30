class Player
    def initialize(name)
        @name = name
    end
end

class Square
    def initialize
        @state = :empty
    end

    def update_state(state)
        @state = state
    end
end

class Board
    def initialize(size)
        @borad = []
        (1..size).each do |s|
            row = []
            (1..size).each do |ss|
                row << Square.new
            end
            @borad << row
        end
    end
end

class Game 
    def initialize(player1, player2, size)
        @player1 = player1
        @player2 = player2
        @board = Board.new(size)
        @turn = @player1
    end

    def play(play_by, move)
        if @turn != play_by
            return "Its not your turn #{play_by}"
        end
        if @board[move[0]][move[1]] != :empty
            return "This Square is already played"
        end
        @board[move[0]][move[1]] = play_by == @player1 ? :X : :O
        check_win_or_not
        @turn = @player2
    end

    def check_win_or_not
    end
end


player1 = Player.new("Smit")
player2 = Player.new("Arpi")
game = Game.new(player1, player2, 3)
game.play(player1, [0, 0])
