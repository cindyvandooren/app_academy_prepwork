class HumanPlayer
	attr_accessor :name, :word_length, :positions

	def initialize
		@name = nil
		@secret_word = nil
		@dictionary = File.readlines("dictionary.txt")
		@guessed_letters = []
		@secret_word_length = nil
		@word_length = nil
		@positions = {}
	end

	# To let the HumanPlayer make a guess, we need to prompt him for a letter.
	# We do that until we have a guess that is valid.
	def guess
		puts "Already guessed letters: #{@guessed_letters.join(", ")}"
		guess = nil
		while guess == nil || invalid?(guess)
			puts "#{self.name}, please take a guess: "
			guess = gets.chomp.downcase
			if invalid?(guess)
				puts "Your guess is invalid. It must be one letter that you haven't guessed before."
			end
		end
		@guessed_letters << guess
		guess
	end

	def invalid?(guess)
		# A guess is invalid when guess == nil, but also when it is a string
		# longer than 1 character, the string is a number of the letter has
		# already been guessed.
		if guess == nil
			true
		elsif guess == ""
			true
		elsif guess.length > 1
			true
		elsif !letter?(guess)
			true
		elsif @guessed_letters.include?(guess)
			true
		else
			false
		end
	end

	def letter?(str)
		str.ord.between?(97, 122)
	end

	def valid?(str)
		str.split("").all? { |l| l.ord.between?(48, 57)} && str.to_i.between?(0, longest_word_in_dictionary)
	end

	# Check if all the characters in the string are a digit or a ,
	def valid_position?(str)
		str.split("").all? { |l| l.chomp.ord.between?(48, 57) || l.chomp.ord == 44 }
	end

	# We ask the player to enter the length of the string he wants to choose.
	# The input is only valid if every single character of the input is an
	# integer and if the input is <= the longest word in the dictionary.
	def ask_for_secret_word_length
		secret_word_length = ""
		while secret_word_length == "" || !valid?(secret_word_length) 
			puts "#{self.name}, please enter the length of the word to guess: "
			secret_word_length = gets.chomp
			if !valid?(secret_word_length)
				puts "Your input is invalid. We need a number between 0 and #{longest_word_in_dictionary}."
			end
		end
		secret_word_length.to_i
	end

	def pick_secret_word
		puts "#{self.name}, please choose a secret word from the dictionary."
		@secret_word_length = ask_for_secret_word_length
		@secret_word_length
	end

	def longest_word_in_dictionary
		@dictionary.sort_by! { |el| el.length }
		@dictionary[-1].length
	end

	def respond_to_guess(guess)
		@guessed_letters << guess
		answer = nil
		until answer == 'y' || answer == 'n'
			puts "Does your secret word have the letter #{guess}? (y/n)"
			answer = gets.chomp.downcase
		end

		if answer == 'y'
			ask_for_positions(guess)
			true
		else 
			false
		end
		# How to indicate where the letters should be and return this information
		# in the display? Then how to return this information to the computer,
		# so that the computer can make an educated guess.

	end

	def ask_for_positions(guess)
		positions = nil
		while positions == nil || valid_position?(positions) == false
			puts "In which positions can we find the guessed letter? (e.g. 0,1,4)"
			positions = gets.chomp
			valid_position?(positions)
		end

		@positions[guess] = positions.split(", ").map { |l| l.chomp.to_i }
	end

	def secret_word_guessed?
		answer = nil
		until answer == 'y' || answer == 'n'
			puts "Has the secret word been guessed? (y/n)"
			answer = gets.chomp.downcase
		end

		answer == 'y' ? true : false
	end

	def display
		puts "Computer picks the next letter."
	end
end