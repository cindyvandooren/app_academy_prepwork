require 'byebug'

class Game
	attr_accessor :board
	def initialize(player1, player2)
		# Eventually we want to be able to initialize two players when we start a new game
		@player1 = HumanPlayer.new(player1, :o)
		@player2 = HumanPlayer.new(player2, :x)
		@board = Board.new
	end

	def start
		puts "Welcome "
	end

	def play
		game_over = false

		until game_over do
			puts "#{@player1.name} in which row would you like to place your marker?"
			row = gets.chomp.to_i
			puts "#{@player1.name} in which column would you like to place your marker?"
			col = gets.chomp.to_i

			self.board.place_mark(row, col, @player1.symbol)
			if self.board.won?(row, col) || self.board.tie?(row, col)
				game_over = true
				break
			end

			puts "#{@player2.name} in which row would you like to place your marker?"
			row = gets.chomp.to_i
			puts "#{@player2.name} in which row would you like to place your marker?"
			col = gets.chomp.to_i

			self.board.place_mark(row, col, @player2.symbol)
			if self.board.won?(row, col) || self.board.tie?(row, col)
				game_over = true
				break
			end
		end	
	end

	def turn(player)

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
		@grid.each { |line| p line }
	end

	def empty?(row, col)
		self[row, col] == nil
	end

	def place_mark(row, col, mark)
		if self.empty?(row, col)
			self[row, col] = mark
			self.show
		else
			puts "This position has already been claimed."
		end
	end

	def won?(row, col)
		# The game is won when one player succeeds in putting 3 of his marks in a row or column or diagonal
		# First we need to know what the latest move was
		# We can probably get this information from the game logic, since we cal call the won method after every move.
		# When we know the last move, we need to test if there is a win in the row, column, first diagonal or second diagonal.
		self.win_on_row?(row, col) || self.win_in_column?(row, col) || self.win_in_first_diagonal? || self.win_in_second_diagonal?
	end

	def win_on_row?(row, col)
		# returns true if there is a win in the row
		# We take the row from the position and we see if on that row there are three of the same symbols
		@grid[row].all? { |mark| mark == :x } || @grid[row].all? { |mark| mark == :o }
	end

	def win_in_column?(row, col)
		# returns true if there is a win in the column
		column_elements = []
		0.upto(@grid.size - 1) { |row| column_elements << @grid[row][col] }
		column_elements.all? { |mark| mark == :x } || column_elements.all? { |mark| mark == :o }
	end

	def win_in_first_diagonal?
		first_diagonal_elements = []
		@grid.each_index do |row|
			@grid.each_index do |col|
				if row == col
					first_diagonal_elements << @grid[row][col]
				end
			end
		end
		first_diagonal_elements.all? { |mark| mark == :x } || first_diagonal_elements.all? { |mark| mark == :o }
	end

	def win_in_second_diagonal?
		second_diagonal_elements = []
		col = @grid.size - 1
		@grid.each_index do |row|
			second_diagonal_elements << @grid[row][col]
			col -= 1
		end
		second_diagonal_elements.all? { |mark| mark == :x } || second_diagonal_elements.all? { |mark| mark == :o }

	end

	def board_full?
		@grid.each_with_index do |row, row_index|
			@grid.each_with_index do |col, col_index|
				if @grid[row_index][col_index] == nil
					return false 
				end
			end
		end
		true
	end

	def tie?(row, col)
		# There is a tie if the board is full and if no one has won.
		self.board_full? && !self.won?(row, col)
	end

	def over?(row, col)
		self.won?(row, col) || self.tied?(row, col)


	def winner
		# The winner is the last player who succeeds in putting 3 of his marks in a row in any direction
	end
end

class HumanPlayer
	attr_accessor :name, :symbol

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

newgame = Game.new("Cindy", "Andre")
newgame.board.show
newgame.start

