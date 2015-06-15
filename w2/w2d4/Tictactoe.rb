class Game
	attr_accessor :board
	def initialize
		# Eventually we want to be able to initialize two players when we start a new game
		@board = Board.new
	end

	def play
		# while every cell in the board is empty we continue to loop
		# Then we break when one of the players win
		# When every cell is full, we see if it is a tie
		#until the game is won or there is a tie we do the following loop
			#player 1 makes a move
				#prompt player to make a move
				# store the players move in pos
				# mark the position on the board
				# use pos to see if the player wins

			# we see if the player wins or if it is a tie
			# player 2 makes a move
			# we see if player 2 wins or if it is a tie
			# player 1 makes a move ....		
	end




end

class Board
	attr_reader :grid

	def initialize
		@grid = Array.new(3) { Array.new(3) }
	end

	def [](row, col)
		@grid[row][col]
	end

	def []=(row, col, mark)
		@grid[row][col] = mark
	end

	def show
		@grid.each do |line|
			p line
		end
	end

	def empty?(pos)
		# Right now, it gives an error, if you enter a position that is off the board.
		self[*pos] == nil
	end

	def place_mark(pos, mark)
		if self.empty?(pos)
			self[*pos] = mark
			self.show
		else
			"This position has already been claimed."
		end
	end

	def won?(pos)
		# The game is won when one player succeeds in putting 3 of his marks in a row or column or diagonal
		# First we need to know what the latest move was
		# We can probably get this information from the game logic, since we cal call the won method after every move.
		# When we know the last move. 
	end

	def win_on_row?(pos)
		# returns true if there is a win in the row
		# We take the row from the position and we see if on that row there are three of the same symbols
		self[pos[0]].all? { |mark| mark == :x } || self[pos[0]].all? { |mark| mark == :o }
	end

	def win_in_column(pos)
	end

	def win_in_diagonal(pos)
	end

	def tie?
		# There is a tie if all the cells of the grid are not empty and if no one has won
	end

	def winner
		# The winner is the last player who succeeds in putting 3 of his marks in a row in any direction
	end

end

class HumanPlayer
	def initialize(name, symbol)
		@name = name
		@symbol = symbol
	end
end

class ComputerPlayer
	def initialize(name, symbol)
		@name = name
		@symbol = symbol
	end
end


game = Game.new
game.board.show
puts game.board.empty?([1,2])
game.board.place_mark([1,2], :o)
game.board.place_mark([1,1], :x)
game.board.place_mark([2,0], :o)
game.board.place_mark([2,1], :o)
game.board.place_mark([2,2], :o)
game.board.win_on_row?([2,2])




