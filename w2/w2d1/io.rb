
def guess
	guessed = false
	secret_number = rand(1..100)
	count = 0

	until guessed
		puts "Choose a number between 1 and 100:"
		input = gets.chomp.to_i

		if input < 1 || input > 100
			puts "This is an invalid input."
			next
		end		

		count += 1
		puts "The count is #{count}."

		if input == secret_number
			puts "You guessed right! The secret number is #{secret_number}. The count is #{count}."
			guessed = true
		elsif 
			input < secret_number
			puts "The secret number is higher."
		else
			puts "The secret number is lower."
		end
	end
end

def file_shuffler
	puts "What file would you like to use?"
	original_file = gets.chomp

	contents = File.readlines(original_file)

	new_file = File.open("#{original_file[0..-5]}-shuffled.txt", "a") do |f|
		contents.shuffle.each do |line|
			f.write(line)
		end
	end
end





