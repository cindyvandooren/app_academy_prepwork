class Hangman
	attr_reader :dictionary, :checking_player, :guessing_player
	
	def initialize(dictionary, player1, player2)
		@dictionary = dictionary
		@guessing_player = player1
		@checking_player = player2
		@checking_player.pick_secret_word('dictionary.txt') if @checking_player.is_a?(HumanPlayer)
		@guessing_player.length = @checking_player.secret_word.length
		@turns = 10
		@guessed_letters = []
		@in_play = true
		play
	end
	
	def play
		while @turns > 0 && @in_play
			turn
		end
		puts "Game over!"
	end
	
	def turn
		@guessing_player.partially_guessed_word = display(@checking_player.secret_word, @guessing_player.guessed_letters)
		guess = @guessing_player.guess
		@guessed_letters << guess
		if @checking_player.check_character(guess)
			if @checking_player.check_win
				@in_play = false
			end
		else
			if @guessing_player.is_a?(HumanPlayer)
				puts "Incorrect guess"
			end
			@turns -= 1
		end
	end
		
	def display(string, guessed_letters)
		output_string = []
		string.split("").each do |char|
			if guessed_letters.include?(char)
				output_string << char
			else
				output_string << "_"
			end
		end
		output_string
	end
	
end

class ComputerPlayer
	attr_reader :secret_word, :length
	attr_accessor :partially_guessed_word
	def initialize
		pick_secret_word('dictionary.txt')
		@guessed_letters = []
		@length = nil
		@list_of_words = nil
		@partially_guessed_word = nil
	end
	
	def pick_secret_word(dictionary='dictionary.txt')
		@secret_word = File.readlines(dictionary).sample.chomp.downcase
	end
	
	def guess
		@list_of_words = File.readlines(dictionary).select{|word| word.length == @length}.sample.chomp if @list_of_words.nil?
		@partially_guessed_word = "_"*@length if @partially_guessed_word.nil?
		prune_list
		guess = most_frequent_letter(@list_of_words)
		while @guessed_letters.include?(guess)
			guess = ("a".."z").to_a.sample
		end
		@guessed_letters << guess
		guess
	end
	
	def check_character(guess)
		@secret_word.split("").include?(guess)
	end
	
	def check_win
		@secret_word.split("").all?{|char| @guessed_letters.include?(char)}
	end
	
	def most_frequent_letter(words_array)
		frequency_hash = {}
		big_string = words_array.join.split("")
		("a".."z").to_a.each do |char|
			frequency_hash[char] = big_string.count(char)
		end
		max_freq_letter = frequency_hash.index(frequency_hash.values.sort.last)
		while @guessed_letters.include?(max_freq_letter)
			frequency_hash[max_freq_letter] = 0
			max_freq_letter = frequency_hash.index(frequency_hash.values.sort.last)
		end
		max_freq_letter
	end
	
	def prune_list
		regex = generate_regex
		@list_of_words = @list_of_words.select{|entry| entry ~= regex}
	end
	
	def generate_regex
		regex = ["\A"]
		@partially_guessed_word.split("").each do |char|
			if char == "_"
				regex << "(\w+)"
			else
				regex << char
			end
			regex << "\Z"

		end
		Regex.new("/" + regex.join + "/")
	end
	# def pick_secret_word(Hangman.dictionary)
	# 	secret_word = nil
	# 	File.foreach(dictionary).each_with_index do |line, number|
	# 		secret_word = line if rand < 1.0 /(number + 1)
	# 	end
	# 	return secret_word.chomp.downcase
	# end
	
end

class HumanPlayer
	attr_reader :secret_word, :length
	attr_accessor :partially_guessed_word
	def initialize
		@secret_word = nil
		@guessed_letters = []
		@length = nil
		@partially_guessed_word = nil
	end
	
	def pick_secret_word(dictionary='dictionary.txt')
		puts "Enter a word length: "
		length = gets.chomp.to_i + 1
		list_of_words = File.readlines(dictionary)
		@secret_word = list_of_words.select{|word| word.length == length}.sample.chomp
		puts "Your word is: #{@secret_word}"
	end
	
	def guess
		guess = gets.chomp.downcase[0]
		while @guessed_letters.include?(guess)
			puts "You already guessed that one!"
			guess = gets.chomp.downcase[0]
		end
		@guessed_letters << guess
		guess
	end
	
	def check_character(guess)
		puts "Is #{guess} in the secret word? (#{@secret_word}) [Y/N]"
		included = gets.chomp.upcase
		while included != "Y" && included != "N"
			puts "Please enter either 'Y' or 'N'"
			included = gets.chomp.upcase
		end
		
		if included == "Y"
			return true
		else
			return false
		end
	end
	
	def check_win
		puts "Is the secret word guessed? [Y/N]"
		included = gets.chomp.upcase
		while included != "Y" && included != "N"
			puts "Please enter either 'Y' or 'N'"
			included = gets.chomp.upcase
		end
		
		if included == "Y"
			return true
		else
			return false
		end
	end
end

if __FILE__ == $PROGRAM_NAME
	player2 = ComputerPlayer.new
	player1 = HumanPlayer.new
	Hangman.new("dictionary.txt", player2, player1)
end


