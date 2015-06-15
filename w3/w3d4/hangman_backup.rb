class Hangman
	attr_reader :dictionary, :checking_player, :guessing_player
	
	def initialize(dictionary, player1, player2)
		@dictionary = dictionary
		@guessing_player = player1
		@checking_player = player2
		@checking_player.pick_secret_word('dictionary.txt') if @checking_player.is_a?(HumanPlayer)
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
		puts display(@checking_player.secret_word, @guessed_letters)
		guess = gets.chomp.downcase[0]
		while @guessed_letters.include?(guess)
			puts "You already guessed that one!"
			guess = gets.chomp.downcase[0]
		end
		@guessed_letters << guess
		if check_character(guess)
			if check_win
				@in_play = false
			end
		else
			puts "Incorrect guess"
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
		"Word to be guessed: " + output_string.join(" ") 
	end
	
	def check_character(guess)
		secret_word = @checking_player.secret_word
		secret_word.split("").include?(guess)
	end
	
	def check_win
		secret_word = @checking_player.secret_word
		secret_word.split("").all?{|char| @guessed_letters.include?(char)}
	end
	
end

class ComputerPlayer
	attr_reader :secret_word
	def initialize
		pick_secret_word('dictionary.txt')
	end
	
	def pick_secret_word(dictionary='dictionary.txt')
		@secret_word = File.readlines(dictionary).sample.chomp.downcase
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
	attr_reader :secret_word
	def initialize
		@secret_word = nil
	end
	
	def pick_secret_word(dictionary='dictionary.txt')
		puts "Enter a word length: "
		length = gets.chomp.to_i + 1
		list_of_words = File.readlines(dictionary)
		@secret_word = list_of_words.select{|word| word.length == length}.sample.chomp
		puts "Your word is: #{@secret_word}"
	end
end

if __FILE__ == $PROGRAM_NAME
	player2 = ComputerPlayer.new
	player1 = HumanPlayer.new
	Hangman.new("dictionary.txt", player1, player2)
end


