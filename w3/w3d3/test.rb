# This is the solution of Razynoir

class Cordinate
	attr_accessor :row, :column, :status
	STATUS = {:blank_unattacked => "\e[36m~ \e[0m", :blank_attacked => "\e[33m@ \e[0m", 
				:ship_unattacked => "O ", :ship_attacked => "\033[1m\e[31m# \e[0m\033[0m"}

	def initialize(row, column)
		@row = row
		@column = column
		@status = :blank_unattacked
	end

	def display
		STATUS[@status]
	end

	def display_as_tracker
		return STATUS[:blank_unattacked] if hanging?
		STATUS[@status]
	end

	def self.[](row, column)
		Cordinate.new(row, column)
	end

	def valid?
		(1..10).include?(row) && (1..10).include?(column)
	end

	def hit!
		@status = :ship_attacked if @status == :ship_unattacked
		@status = :blank_attacked if @status == :blank_unattacked
	end

	def occupy
		@status = :ship_unattacked
	end

	def empty?
		@status == :blank_unattacked
	end

	def dead?
		@status == :ship_attacked
	end

	def hanging?
		@status == :ship_unattacked
	end

	def probed?
		@status == :blank_attacked
	end

	def ==(other_cord)
		@row == other_cord.row && @column == other_cord.column && @status == other_cord.status
	end
end

class Grid
	include Enumerable
	attr_accessor :multi_array

	def initialize
		@multi_array = Array.new(10) {Array.new(10)}
		(0..9).each do |i|
			(0..9).each do |j|
				@multi_array[i][j] = Cordinate.new(i + 1, j + 1)
			end
		end
	end

	def each
		@multi_array.each do |row|
			row.each { |cord| yield cord }
		end
	end

	def [](cordinate)	# instead of a pair of number, pass in a Cordinate object
		@multi_array[cordinate.row - 1][cordinate.column - 1]
	end

	def region(anchor, down, right)
		select { |cord| (anchor.row..anchor.row + down - 1).include?(cord.row) && 
						(anchor.column..anchor.column + right - 1).include?(cord.column) }
	end

	def region_clear?(anchor, down, right)
		if anchor == Cordinate[0, 0] || out_of_bound?(anchor.row + down) || out_of_bound?(anchor.column + right)
			return false
		else
			region(anchor, down, right).select { |cord| !cord.empty? }.empty?
		end
	end

	def display
		@multi_array.each do |row|
			row.each { |cord| print cord.display }
			puts
		end
	end

	def display_as_tracker
		@multi_array.each do |row|
			row.each { |cord| print cord.display_as_tracker }
			puts
		end
	end

	def occupy_cordinates(anchor, down, right)
		select { |cord| (anchor.row..anchor.row + down - 1).include?(cord.row) && 
						(anchor.column..anchor.column + right - 1).include?(cord.column)
		}.map! { |cord| cord.occupy }
	end

	def bangable?(cord)
		self[cord].empty? || self[cord].hanging?
	end

	def fire_at(cord)
		self[cord].hit!
	end

	def out_of_bound?(num)
		num > 10
	end
end

class Board
	attr_accessor :grid, :ships

	def initialize
		@grid = Grid.new
		@ships = []
	end

	def display
		puts "    Your Board   "
		@grid.display
		puts
		puts "Your Ships:"
		@ships.select {|ship| puts ship.display }
		20.times {print "-" }
		puts
	end

	def display_as_tracker
		puts "  Opponent Tracker  "
		@grid.display_as_tracker
		puts
		puts "Opponent's Ships:"
		@ships.select {|ship| puts ship.display }
		20.times {print "-" }
		puts
	end

	def count
		@ships.select { |ship| !ship.gone? }.size
	end

	def place_ship(ship, cord)
		if @grid.region_clear?(cord, ship.long, ship.beam)
			ship.log_cordinates(@grid.region(cord, ship.long, ship.beam))
			@grid.occupy_cordinates(cord, ship.long, ship.beam)
			@ships << ship
		else
			false
		end
	end

	def bang!(cord)
		if @grid.bangable?(cord)
			@grid.fire_at(cord)
			true
		else
			false
		end
	end

	def done?
		count == 0
	end

	def ajacent_cords(anchor)
		@grid.region(Cordinate[anchor.row - 1, anchor.column - 1], 3, 3)
	end

	def status(cord)
		return @grid[cord].status
	end
end

class Ship
	attr_accessor :name, :long, :beam, :alive_cordinates

	def initialize(name = "Bogey", long = 1, beam = 1)
		@name = name
		@long = long
		@beam = beam
		@alive_cordinates = []
	end

	def gone?
		alive_cordinates.select {|cord| cord.hanging? }.empty?
	end

	def take_hit(pos)
		@alive_cordinates.select! { |cord| cord != pos } if alive_cordinates.include?(pos)
	end

	def log_cordinates(cordinates)
		@alive_cordinates = cordinates
		@alive_cordinates.each { |cord| cord.occupy }
	end

	def display
		return "(Perished) " + @name if gone?
		return @name
	end

	def self.clone
		Ship.new(@name, @long, @beam)
	end

	def change_direction
		@long, @beam = @beam, @long
		return self
	end
end

class Player
	attr_accessor :board

	def initialize
		@board = Board.new
	end

	def place_these_ships(ship_list = [])
	end

	def bang(opponent_board)
	end

	def input_cordinate
	end

	def reveal_tracker
		@board.display_as_tracker
	end

	def reveal_board
		@board.display
	end

	def lost?
		@board.done?
	end
end

class HumanPlayer < Player

	def place_these_ships(ship_list = [])
		ship_list.each do |ship| 
			@board.display
			loop do
				puts "Now positioning #{ship.name} (#{ship.long}x#{ship.beam})"
				orient = input_orientation
				cord = input_cordinate
				if orient == "Y"
					break if @board.place_ship(ship.clone.change_direction, cord)
				else
					break if @board.place_ship(ship.clone, cord)
				end
				5.times{ puts }
			end
		end
		puts "Ships are placed."
		5.times{ puts }
	end

	def bang(opponent_board)
		loop do
			puts "Where do you want to fire at?"
			cord = input_cordinate
			break if opponent_board.bang!(cord)
		end
	end

	def input_cordinate
		cord = Cordinate[0, 0]
		until cord.valid?
			puts "Input the row or column for the action"
			print "Which row: "
			row = gets.chomp.to_i
			print "Which column: "
			column = gets.chomp.to_i
			cord = Cordinate[row, column]
		end
		cord
	end

	def input_orientation
		orientation = nil
		until orientation == "Y" || orientation =="N"
			puts "Do you want to place horizontally? (Y/N)"
			orientation = gets.chomp.upcase.to_s
		end
		orientation
	end

	def need_display?
		true
	end
end

class ComputerPlayer < Player
	attr_accessor :high_potential_cords, :last_hit_cord, :nonhit_count

	def initialize
		@board = Board.new
		@high_potential_cords = []
		@last_hit_cord = nil
		@nonhit_count = 0
	end

	def place_these_ships(ship_list = [])
		ship_list.each do |ship| 
			loop do
				orient = input_orientation
				cord = input_cordinate
				if orient == "Y"
					break if @board.place_ship(ship.clone.change_direction, cord)
				else
					break if @board.place_ship(ship.clone, cord)
				end
			end
		end
	end

	def bang(opponent_board)
		cord = Cordinate[0, 0]
		loop do
			if @high_potential_cords == []
				cord = input_cordinate
			else
				cord = @high_potential_cords.shuffle![0]
			end
			break if opponent_board.bang!(cord)
		end
		update_optimal_choices(opponent_board, cord)
	end

	def update_optimal_choices(opponent_board, cord)
		if opponent_board.status(cord) == :ship_attacked
			@last_hit_cord = cord
			@nonhit_count = 0
			@high_potential_cords = @board.ajacent_cords(cord)
		else
			@nonhit_count += 1
		end

		if @nonhit_count >= 3
			@last_hit_cord = nil
			@high_potential_cords = []
			@nonhit_count = 0
		end
	end

	def input_cordinate
		cord = Cordinate[0, 0]
		until cord.valid?
			row = Random.new.rand(10) + 1
			column = Random.new.rand(10) + 1
			cord = Cordinate[row, column]
		end
		cord
	end

	def input_orientation
		choices = ["Y", "N"]
		orientation = choices[Random.new.rand(2)]
		orientation
	end

	def need_display?
		false
	end
end

class BattleshipGame
	attr_accessor :players, :current_player, :current_opponent, :turn
	SHIPS_IN_PLAY = [Ship.new("Carrier", 5, 1),
					 Ship.new("Battleship", 4, 1),
					 Ship.new("Submarine", 3, 1),
					 Ship.new("Cruiser", 3, 1),
					 Ship.new("Patrol", 2, 1)]

	def initialize(player1, player2)
		@players = [player1, player2]
		@current_player = nil
		@current_opponent = nil
		@turn =  0
	end

	def titlize(string)
		"\033[1m#{string}\n\033[0m"
	end

	def run
		set_up
		until won?
			puts titlize("PLAYER #{turn % 2 + 1}'S TURN")
			@current_player = @players[turn % 2]
			@current_opponent = @players[(turn + 1) % 2]
			play_turn
			@turn += 1
		end
		win
	end

	def set_up
		@players.each { |player| player.place_these_ships(SHIPS_IN_PLAY.clone) }
	end

	def play_turn
		if @current_player.need_display?
			@current_opponent.reveal_tracker
			@current_player.reveal_board
		end
		@current_player.bang(@current_opponent.board)
		5.times{ puts }
	end

	def win
		puts "Player #{(turn - 1) % 2 + 1} won the game!"
	end

	def won?
		@players.any? { |player| player.lost? }
	end
end


player1 = HumanPlayer.new
player2 = ComputerPlayer.new

battleship_game = BattleshipGame.new(player1, player2)
battleship_game.run
