require 'byebug'

class Game
	attr_reader :steps
  # When the game starts, a new secret code for the user to guess needs to be generated.
  def initialize
    @secret_code = Code::random
    @steps = 0
    @guess = nil
    @in_play = true
  end

  def turn
  	@steps += 1
  	@guess = nil
  	while @guess == nil
  		print "Please, take a guess:"
  		@guess = Code::parse(gets.chomp)
  	end
  end

  def play
  	while @in_play && @steps < 10
  		turn
  		@guess.compare_codes(@secret_code)
  		if won?
  			puts "You have won the game in #{steps} steps"
  			@in_play == false
  		end
  	end

  	if won? == false
  		puts "You have lost the game. Please try again."
  	end
  end

  def won?
  	@guess.guessed?(@secret_code)
  end
end

class Code
  attr_reader :seq
  
  COLORS = %w(R G B O P Y)
  
  def initialize(seq)
  	@seq = seq
  end

  # Makes a random sequence of pegs for the user to guess.
  def self.random
  	Code.new(Array.new(4) { COLORS.sample })
  end

  # Generates a new code object with a sequence based on the input of the user.
  def self.parse(input)
  	if valid_input?(input)
      Code.new(input.upcase.split(""))
    else
      puts "This is not a valid input."
      nil
    end
  end

  # Checks if the input for a new sequence is valid (4 letters chosen from COLORS).
  def self.valid_input?(input)
    input.split("").size == 4 && input.upcase.split("").all? { |letter| COLORS.include?(letter) }
  end
  
  # Checks the number of near matches.
  def near_matches(other_code)
    own_code = self.hash_code
    oth_code = other_code.hash_code

    near_matches = 0
    exact_matches = self.exact_matches(other_code)

    own_code.each do |key, value|
      # if both hashes have the key, than you should take the lowest value
      if oth_code.keys.include?(key)
        near_matches += [oth_code[key], own_code[key]].min
      end
    end
    near_matches - exact_matches
  end

  # This is a helper method to make a hash of the sequence showing the number of times
  # each color has been used.
  def hash_code
    hash_code = {}
    self.seq.each do |letter|
      hash_code.keys.include?(letter) ? hash_code[letter] += 1 : hash_code[letter] = 1
    end
    hash_code
  end
  
  # This is a helper method to find out if a particular letter is an exact match.
  def is_exact_match?(other_code, index)
    @seq[index] == other_code.seq[index]
  end

  # Checks how many of the pegs are in the correct place. 
  def exact_matches(other_code)
    exact_matches = 0
    @seq.each_with_index do |letter, index|
      exact_matches += 1 if self.is_exact_match?(other_code, index)
    end
    exact_matches
  end
  
  # This method will use the exact_matches and near_matches methods to give a response
  # to the player.
  def compare_codes(other_code)
  	exact = self.exact_matches(other_code)
  	near = self.near_matches(other_code)
  	puts "There are #{exact} exact_matches and #{near} near matches."
  end
  
  # This method will determine if two codes are the same.
  def guessed?(other_code)
    self.exact_matches(other_code) == 4
  end
end

d= Game.new
d.play