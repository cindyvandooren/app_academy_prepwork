def longest_word(file)
	File.readlines(file).each do |line|
		puts longest_word_in_line(line)
	end
end

def longest_word_in_line(line)
	longest_size = 0
	longest_word = nil

	line.split(" ").each do |word|
		if word.size > longest_size
			longest_size = word.size
			longest_word = word
		end
	end
	longest_word
end

if __FILE__ == $PROGRAM_NAME
	if ARGV.empty?
		longest_word("longest_word_file.txt")
	else 
		longest_word("#{ARGV[0]}")
	end
end