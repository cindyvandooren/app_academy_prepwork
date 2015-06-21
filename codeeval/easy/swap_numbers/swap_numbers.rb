def swap_numbers(file)
	content = File.readlines(file)
	content.each do |sentence|
		result = []
		sentence.split(" ").each do |word|
			result << swap_numbers_word(word)
		end
		puts result.join(" ")
	end
end

def swap_numbers_word(word)
	word[0], word[-1] = word[-1], word[0]
	word
end

if __FILE__ == $PROGRAM_NAME
	if ARGV.empty?
		swap_numbers("swap_numbers_file.txt")
	else
		swap_numbers("#{ARGV[0]}")
	end
end

