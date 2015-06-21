# This is the implementation of the A* algorithm 
# Resource: http://www.policyalmanac.org/games/aStarTutorial.htm

require 'byebug'

class MazeSolver
	COST_ORT = 10
	COST_DIA = 14

	attr_accessor :current_pos

	def initialize(maze_file)
		@maze = File.readlines(maze_file).map!{ |l| l.chomp.split("")}
		@start_pos = find_pos("S")
		@end_pos = find_pos("E")
		@current_pos = @start_pos

		@open = [@start_pos]
		@closed = []

		@parents = {}
		@gcosts = {@start_pos => 0}
		@hcosts = {}
		@fcosts = {}
	end

	def find_way_out
		initial_turn

		until @closed.include?(@end_pos) || @open.empty?
			# We move the next parent from open to closed.
			@open.delete(@current_pos)
			@closed << @current_pos
			break if @closed.include?(@end_pos)


			#  Next step is to search for adjacent squares, but ignore the
			# ones that are in the closed list and the ones that are 
			# unwalkable.
			adj = find_reachable_adjacents
			# Now we have all the reachable adjacents, we need to check 
			# if they are already in the open list. If the adj is in the 
			# open list, we need to compare the gcosts. # if the gcost is
			# lower now than with the previous parrent, we change the 
			# parrent of that position and recalculate the gcost and fcost.
			# If not, we just add the position to the open list.
			adj.each do |p|
				if @open.include?(p)
					if compare_gscores(p)
						@parents[p] = @current_pos
						@gcosts[p] = calculate_gcost(p, @current_pos)
						@fcosts[p] = calculate_fcost(p)
					end
				else
					@open << p
					@parents[p] = @current_pos
				end
			end

			@current_pos = pick_next_parent

		end
		mark_route
		display_maze

	end

	def find_route
		path = [@end_pos]

		until path.include?(@start_pos)
			path << @parents[path.last]
		end

		path
	end

	def mark_route
		path = find_route
		path.each do |p|
			if p == @start_pos
				next
			elsif p == @end_pos
				next
			else
				self[*p] = "x"
			end
		end

	end

	def initial_turn
		# First thing we need to do, is find the reachable/walkable
		# adjacent squares and add them to the open list.
		store_reachable_adjacents
		puts
		# Then we move the starting position from the open to the
		# closed list.
		@open.delete(@current_pos)
		@closed << @current_pos
		# The next step is to pick the next parent position
		@current_pos = pick_next_parent
	end

	def compare_gscores(p)
		# We need to see if the gcost with the previous parent is
		# higher than the gcost with the current_pos as a parent.
		# The gscore with the previous parent is stored in @gcosts.
		old_gcost = @gcosts[p]
		new_gcost = calculate_gcost(p, @current_pos)
		new_gcost < old_gcost
	end

	def pick_next_parent
		# We first need to calculate the
		# gcost, hcost and fcost for each position in the open list.
		calculate_costs
		# Then we need to find the pos with the lowest fcost.
		# We cannot take into account the fcosts of positions that
		# are already on the closed list.
		temp_fcosts = @fcosts.select{|k, v| !@closed.include?(k) }
		temp_fcosts.sort_by{ |k, v| v }[0][0]
	end

	def calculate_costs
		# We calculate the costs for all the positions in open
		# that don't have a gcost yet.
		@open.each do |p|
			if !@gcosts.keys.include?(p)
				parent = @parents[p]
				@gcosts[p] = calculate_gcost(p, parent)
				@hcosts[p] = calculate_hcost(p)
				@fcosts[p] = calculate_fcost(p)
			end
		end
	end

	# This calculates the gcost for one position.
	# The gcost is the gcost of the parent + cost to move from
	# parent to the position. 
	def calculate_gcost(p, parent)
		if is_ortho?(p, parent)
			gcost = @gcosts[parent] + COST_ORT
		else
			gcost = @gcosts[parent] + COST_DIA
		end
	end

	# This calculates the hcost for one position.
	# The hcost is the cost to the end position only using
	# vertical and horizontal movements and ignoring walls.
	def calculate_hcost(p)
		distance = (@end_pos[0] - p[0]).abs + (@end_pos[1] - p[1]).abs
		distance * COST_ORT
	end

	# This calculates the fcost for one position.
	# The fcost is the gcost + the hcost for a position.
	def calculate_fcost(p)
		@hcosts[p] + @gcosts[p]
	end

	def is_ortho?(pos, parent)
		!((parent[0] - pos[0]).abs >= 1 && (parent[1] - pos[1]).abs >= 1)
	end


	def find_all_adjacents
		all_adjacents = [
							# [@current_pos[0] - 1, @current_pos[1] - 1],
							# [@current_pos[0] - 1, @current_pos[1] + 1],
							# [@current_pos[0] + 1, @current_pos[1] + 1],
							# [@current_pos[0] + 1, @current_pos[1] - 1],
							[@current_pos[0] - 1, @current_pos[1]    ],
							[@current_pos[0] + 1, @current_pos[1]    ],
							[@current_pos[0]    , @current_pos[1] + 1],
							[@current_pos[0]    , @current_pos[1] - 1]
						]
	end

	# We find the reachable adjacents by going through all adjacents
	# and checking if they are free and if they are not in the
	# closed list.
	def find_reachable_adjacents
		find_all_adjacents.select { |p| (is_free?(p) && !@closed.include?(p)) }
	end

	# We will store the reachable adjacents we found in @open and
	# store it with a parent in @parents
	def store_reachable_adjacents
		find_reachable_adjacents.each do |p|
			@open << p
			@parents[p] = @current_pos
		end
	end

	def display_maze
		@maze.each { |l| p l }
	end

	def display_lists
		puts "Open list: #{@open}"
		puts "Closed list: #{@closed}"
		puts "Parent list: #{@parents}"
		puts "Gcost list: #{@gcosts}"
		puts "Fcost list: #{@fcosts}"
		puts "Hcost list: #{@hcosts}"
	end

	def [](row, col)
		@maze[row][col]
	end

	def []=(row, col, mark)
		@maze[row][col] = mark
	end

	def find_pos(name)
		pos = nil 
		(0...@maze.size).each do |row|
			(0...@maze[row].size).each do |col|
				if @maze[row][col] == name
					pos = [row, col]
				end
			end
		end
		pos
	end

	def is_free?(pos)
		self[*pos] == " " || self[*pos] == "E"
	end

end

# if __FILE__ == $PROGRAM_NAME
# 	if ARGV.empty?
# 		MazeSolver.new("maze.txt").find_way_out
# 	else
# 		MazeSolver.new("#{ARGV[0]}").find_way_out
# 	end
# end

c = MazeSolver.new("harder_maze.txt")
c.display_maze
c.find_way_out


