class ComputerPlayer
	attr_accessor :name, :word_length

	def initialize
		@dictionary = File.readlines("dictionary.txt")
		@secret_word = nil
		@guessed_letters = []
		@secret_word = nil
		@name = "computer"
		@word_length = nil
		@hash_to_sort = nil
		@guessing_array = []
		@guessing_letter = nil
		@smart_dictionary = {}
	end

	# Computer randomly picks a secret word from the dictionary.
	def pick_secret_word
		@secret_word = @dictionary.sample.chomp.downcase
		@secret_word.length
	end

	# Responds to the guess of the other player.
	def respond_to_guess(guess)
		@guessed_letters << guess
		@secret_word.split("").include?(guess)	
	end

	# Dertermines whether the entire secret word has been guessed.
	def secret_word_guessed?
		@secret_word.split("").all? { |letter| @guessed_letters.include?(letter) }
	end

	# Displays the progress of the guessing game.
	def display
		secret_word_display = []
		@secret_word.split("").each do |char|
			if @guessed_letters.include?(char)
				secret_word_display << char
			else
				secret_word_display << "_"
			end
		end
		puts "Secret word: #{secret_word_display.join(" ")}"
	end

	# Computer makes a guess, based on the frequency of the letters.
	def guess
		collect_words_of_length
		puts "Already guessed letters by computer: #{@guessed_letters}"
		@guessing_letter = nil
		while @guessing_letter == nil || invalid?(@guessing_letter)
			@guessing_letter = guessing_letter
		end
		@guessed_letters << @guessing_letter
		@guessing_letter
	end

	# Collects all words from the dictionary with the correct length.
	def collect_words_of_length
		@dictionary.select! { |el| el.length == @word_length + 1 }
		make_smart_dictionary
	end

	# Makes a hash of all the letters in the word and the number of occurrences
	def make_smart_dictionary
		@smart_dictionary = {}
		@dictionary.each do |el|
			el.chomp.split("").each do |key|
				if @smart_dictionary.keys.include?(key)
				 @smart_dictionary[key] += 1
				else
					@smart_dictionary[key] = 1
				end
			end
		end
		@hash_to_sort = @smart_dictionary.sort_by { |k,v| v }.map { |k,v| k }
	end

	def guessing_letter
		@hash_to_sort.pop
	end

	def translate_positions(positions)
		word = []
		@word_length.times { word << "." }
		positions.each do |key,values|
			values.each do |v|
				word[v] = key
			end
		end
		word
	end

	def keep_correct_words(positions)	
		word = translate_positions(positions)
		regex = '\A' + word.join('')
		@dictionary = @dictionary.select { |word| word.chomp =~ Regexp.new(regex)}
	end

	def remove_incorrect_words(guess)
		@dictionary = @dictionary.select { |word| !word.chomp.include?(guess)}
	end

	# Checks if the guess is invalid, based on the letters the computer 
	# has already used.
	def invalid?(guess)
		@guessed_letters.include?(guess)
	end
end
