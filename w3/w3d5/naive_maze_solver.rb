# This maze solver assumes that there is a path out of the
# maze that doesn't intersect itself. If there is no way out,
# the maze solver will loop infinitely.

require 'byebug'

class MazeSolver
	attr_accessor :maze_file, :maze

	def initialize(maze_file)
		@maze_file = maze_file
		@maze = Maze.new(@maze_file)
		@start_pos = @maze.find_start
		@end_pos = @maze.find_end
		@maze.unmark_end(@end_pos)
		@pawn = Pawn.new
		@game_over = false
	end

	# The game loop will be put in this function.
	def find_way_out
		#Step 1: Put the pawn on the start_pos.
		@pawn.current_pos = @start_pos

		# Step 2: The pawn should check if it can go right, left, up, down.
		# If it can, it should go in the first direction it can.
		# If it can't, then the maze can't be solved.
		until @game_over
			make_a_move
			@maze.place_pawn(@pawn.current_pos, @pawn.name)

		# Step 3: After every move we need to check if the pawn is at the E.
			@game_over = true if reached_end?
		end
	end

	def make_a_move
		# This will wipe terminal clean (start at the top every time)
		system "clear"
		if @maze.space_free_right?(@pawn.current_pos)
			@pawn.go_right
			@maze.place_pawn(@pawn.current_pos, @pawn.name)
		elsif @maze.space_free_up?(@pawn.current_pos)
			@pawn.go_up
			@maze.place_pawn(@pawn.current_pos, @pawn.name)
		elsif @maze.space_free_left?(@pawn.current_pos)
			@pawn.go_left
			@maze.place_pawn(@pawn.current_pos, @pawn.name)
		elsif @maze.space_free_down?(@pawn.current_pos)
			@pawn.go_down
			@maze.place_pawn(@pawn.current_pos, @pawn.name)
		else
			@maze.place_marker(@pawn.current_pos)
			@maze.unmark_path
			@pawn.current_pos = @start_pos
		end
		puts
		@maze.display
	end

	def reached_end?
		@pawn.current_pos == @end_pos
	end
end

class Maze
	attr_accessor :grid

	def initialize(maze_file)
		@maze_file = maze_file
		@grid = []
		setup_maze
	end

	def setup_maze
		arr = File.readlines(@maze_file)
		arr.each do |line|
			@grid << line.chomp.split("")
		end
	end

	def [](row, col)
		@grid[row][col]
	end

	def []=(row, col, mark)
		@grid[row][col] = mark
	end

	def display
		@grid.each { |line| p line }
	end

	def place_pawn(pos, name)
		self[*pos] = name
	end

	def place_marker(pos)
		self[*pos] = "X"
	end

	def unmark_end(pos)
		self[*pos] = " "
	end

	def unmark_path
		(0..@grid.size - 1).each do |row|
			(0..@grid[row].size - 1).each do |col|
				if @grid[row][col] == "P"
					@grid[row][col] = " "
				end
			end
		end
	end

	def find_start
		pos = nil
		(0..@grid.size - 1).each do |row|
			(0..@grid[row].size - 1).each do |col|
				if @grid[row][col] == "S"
					pos = [row, col]
					break
				end
			end
		end
		pos
	end

	def find_end
		pos = nil 
		(0..@grid.size - 1).each do |row|
		  (0..@grid[row].size - 1).each do |col|
				if @grid[row][col] == "E"
					pos = [row, col]
					break
				end
			end
		end
		pos
	end

	def space_free_right?(pos)
		self[pos[0], pos[1] + 1] == " " ? true : false
	end

	def space_free_up?(pos)
		self[pos[0] - 1, pos[1]] == " " ? true : false
	end

	def space_free_left?(pos)
		self[pos[0], pos[1] - 1] == " " ? true : false
	end

	def space_free_down?(pos)
		self[pos[0] + 1, pos[1]] == " " ? true : false
	end
end

class Pawn
	attr_accessor :name, :current_pos

	def initialize
		@name = "P"
		@current_pos = current_pos
	end

	def go_right
		@current_pos = [@current_pos[0], @current_pos[1] + 1]
	end

	def go_up
		@current_pos = [@current_pos[0] - 1, @current_pos[1]]
	end

	def go_left
		@current_pos = [@current_pos[0], @current_pos[1] - 1]
	end

	def go_down
		@current_pos = [@current_pos[0] + 1, @current_pos[1]]
	end
end

if __FILE__ == $PROGRAM_NAME
	if ARGV.empty?
		MazeSolver.new("maze.txt").find_way_out
	else 
		MazeSolver.new("#{ARGV[0]}").find_way_out
	end
end

