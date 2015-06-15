require 'byebug'
require 'colorize'

class Board
  attr_reader :grid

  def initialize
    @grid = Array.new(10) { Array.new(10, "w") }
    @number_of_ships = 10
  end

  # Allows us to get positions using board(row, col)
  def [](row, col)
    @grid[row][col]
  end

  # Allows us to set markers using board(row, col, mark)
  def []=(row,col, mark)
    @grid[row][col] = mark
  end

  # Prints the game board in a readible way.
  def display
    @grid.each { |line| p line }
  end

  # Gives colors to the board, to make it more readible.
  # Does not seem to work, it displays the color codes instead.
  def colorize
    (0..self.size - 1).map do |row|
      (0..self.size - 1).map do |col|
        pos = [row,col]
        if self[*pos] == "w"
          self[*pos] = "w".colorize(:blue)
        elsif self[*pos] == "e"
          self[*pos] = "e".colorize(:red)
        elsif self[*pos] == "s"
          self[*pos] = "s".colorize(:yellow)
        elsif self[*pos] == "t"
          self[*pos] = "t".colorize(:black)
        end
      end
    end
  end

  # Randomly puts ships on the board.
  def populate_grid
    @number_of_ships.times do
      ship_placed = false
      until ship_placed
        random_position = random_pos
        if is_water?(random_position)
          place_ship(random_position)
          ship_placed = true
        end
      end
    end
  end

  # Checks if a given position is on the board
  def in_range?(pos)
    pos[0].between?(0, @grid.size - 1) && pos[1].between?(0, @grid.size - 1)
  end

  # Generates a random_pos that is on the board
  def random_pos
    [rand(@grid.size), rand(@grid.size)]
  end

  # Checks if a position is occupied by a ship
  def occupied_by_ship?(pos)
    self[*pos] == "s"
  end

  # Checks if a position has already been targeted 
  # :e is for exploded ship, :t is for target that was water.
  def already_targeted?(pos)
    self[*pos] == "t" || self[*pos] == "e"
  end

  # Checks if a position is empty, so if there is only water
  def is_water?(pos)
    self[*pos] == "w"
  end

  # Places a ship
  def place_ship(pos)
   self[*pos] = "s"
  end

  # Returns the size of the board
  def size
    @grid.size
  end

  # Counts the number of valid targets remaining
  def count
    counter = 0
    (0..self.size - 1).each do |row|
      (0..self.size - 1).each do |col|
        pos = [row, col]
        if occupied_by_ship?(pos)
          counter += 1
        end
      end
    end
    counter
  end

end

class HumanPlayer
  def initialize
  end

  def valid?(input)
    # debugger
    v_input = prepare_input(input)
    # Check if the size of the resulting array is equal to 2
    if v_input.size != 2
      return false
    # Check if all the elements in the array have only one character
    elsif !v_input.all? { |char| char.length == 1 }
      return false
    # Check if all the elements in the array are numbers
    elsif !v_input.all? { |char| char.ord.between?(48, 57) }
      return false
    else
      true
    end
  end

  def translate(input)
    t_input = prepare_input(input)
    [t_input[0].to_i, t_input[1].to_i]
  end

  def prepare_input(input)
    input = input.split(",")
    prepared_input = input.map { |char| char.strip }
  end
end

class ComputerPlayer
  def initialize
    @fired_positions = [nil]
  end

  def fire
    # Pick a random position until you have one that you haven't already
    # attacked. 
    pos = nil
    while @fired_positions.include?(pos)
      pos = fire_random_pos
    end

    pos

    # Verify if that position has already been attacked (by looking at "e" and "f") on the board
    # if so, pick another random positions.
  end

  def fire_random_pos
    [rand(10), rand(10)]
  end



  # We'll make the computer automatically fire positions to the board.
  # We'll do this by making random positions that are in the scope of the 
  # board. Then we keep track of these positions.
  # Before we fire a random position, we will see if we fired it before. Or should
  # we do this using the board, because we can see which positions we already attacked.


end

class BattleshipGame
  
  # We create a guessing_board for the player to guess the place of the 
  # ships. We also create a board for the player that he can use to keep 
  # track of his earlier guesses.
  def initialize
    @guessing_board = Board.new
    @player_board = Board.new
    @player = HumanPlayer.new
    @in_play = true
  end

  # Runs the game by calling play_turn until the game is over
  def play
    @guessing_board.populate_grid
    until @guessing_board.count <= 0
      play_turn
    end
    puts "Congratulations, you have finished the game!"
  end

  # Gets a guess from the player and makes an attack.
  def play_turn
    # If the player is a ComputerPlayer, we call the 
    # prompt the player to deliver an input, until the input is valid.
    
    if @player.is_a?(HumanPlayer)
      input = "invalid input"
      until @player.valid?(input) == true do
        puts "In which row and column do you think the ship is hiding? (row, column)"
        input = gets.chomp
      end
      # Then we translate the input.
      pos = @player.translate(input)
    else
      pos = @player.fire
    end

    # Then we attack with this position.
    attack(pos)

    # Then we display the player_board, so that the player can decide on 
    # the next turn.
    display_status
  end

  # Marks the board at the pos, destroying or replacing any ship 
  # that might be there.
  def attack(pos)
    if @guessing_board.already_targeted?(pos)
      puts "You have targeted this position before."
    elsif @guessing_board.is_water?(pos)
      puts "You have missed."
      @guessing_board[*pos] = "t"
      @player_board[*pos] = "t"
    elsif @guessing_board.occupied_by_ship?(pos)
      puts "You hit a ship."
      @guessing_board[*pos] = "e"
      @player_board[*pos] = "e"
    else
      puts "Something must have gone wrong."
    end
  end

  # Prints information on the current state of the game, including
  # board state and the number of ships remaining.
  def display_status
    puts "Ships to find: #{@guessing_board.count}"
    @player_board.display
  end
end

d = BattleshipGame.new
d.play






