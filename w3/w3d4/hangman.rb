require 'byebug'
require './human'
require './computer'

class Hangman
	attr_accessor :guess

	def initialize
		@choosing_player = nil
		@guessing_player = nil
		@guess = nil
		@guessed_letters = []
		@turns_left = 10
		@secret_word_guessed = false
	end

	# Asks the player if he wants to be the one guessing or the one making
	# up the secret word.

	def setup
		# First ask the player if he wants to choose a secret word. 
		# Prompt until he answers y/n.
		choosing_answer = nil
		until choosing_answer == 'y' || choosing_answer == 'n'
			puts "Do you want to choose a secret word? (y/n)"
			choosing_answer = gets.chomp.downcase
		end

		# If the player wants to choose the secret word, initiate the game.
		# If the player doesn't want to, we have to ask the player if he wants
		# to guess the secret word. # We prompt until we have an answer y/n.
		if choosing_answer == 'y'
			puts "I'll start the game."
			choosing_player_name = nil
			while choosing_player_name == nil
				puts "What's your name?"
				choosing_player_name = gets.chomp
			end
			@choosing_player = HumanPlayer.new
			@choosing_player.name = choosing_player_name
			@guessing_player = ComputerPlayer.new
			play
		else
			guessing_answer = nil
			until guessing_answer == 'y' || guessing_answer == 'n'
				puts "Do you want to guess a secret word? (y/n)"
				guessing_answer = gets.chomp.downcase
			end
			if guessing_answer == 'y'
				puts "I'll start the game."
				guessing_player_name = nil
				while guessing_player_name == nil
					puts "What's your name?"
					guessing_player_name = gets.chomp
				end
			  @choosing_player = ComputerPlayer.new
			  @guessing_player = HumanPlayer.new
			  @guessing_player.name = guessing_player_name
			  play
			else
				puts "You don't want to play the game. The game ends here."
			end
		end
	end

	# This is the start of the game loop.
	def play
		# First step: make the choosing player choose a secret word.
		puts "We are playing Hangman."
		@guessing_player.word_length = @choosing_player.pick_secret_word

		until @secret_word_guessed || @turns_left <= 0
			turn
		end

		# Fourth step: Finish the game. See if the player has won and give
		#appropriate output. Ask the player if he wants to play another game. 
		if @secret_word_guessed && @turns_left >= 0
			puts "#{@guessing_player.name} has won the game. Congratulations!"
		else
			puts "Unfortunately #{@guessing_player.name} did not guess the secret word."
		end

		play_again_answer = nil
		until play_again_answer == 'y' || play_again_answer == 'n'
			puts "Would you like to play another game? (y/n)"
			play_again_answer = gets.chomp.downcase
		end

		if play_again_answer == 'y'
			initialize
			setup
		else
			"Thank you for playing this game. We hope to see you again soon."
		end
	end

	def turn
		# Second step: make the guessing player take a guess.
		@choosing_player.display
		puts "Turns left: #{@turns_left}"
		@guess = @guessing_player.guess

		# Third step: make the choosing player respond to that guess and see if
		# the game has been won. (If not, back to step 2. If so, step 4.)
		if @choosing_player.respond_to_guess(@guess)
			if @guessing_player.is_a?(ComputerPlayer)
				@guessing_player.keep_correct_words(@choosing_player.positions)
			end
		else
			if @guessing_player.is_a?(ComputerPlayer)
				@guessing_player.remove_incorrect_words(@guess)
			end
			@turns_left -= 1
		end
		@secret_word_guessed = true if @choosing_player.secret_word_guessed?
	end
end

if __FILE__ == $PROGRAM_NAME
	Hangman.new.setup
end