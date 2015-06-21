def reverse_words(file)
	content = File.readlines(file)
	content.each do |line|
		split_line = line.split(" ")
		new_line = []
		(split_line.size).times do 
			new_line << split_line.pop
		end
		puts new_line.join(" ")
	end
end

if __FILE__ == $PROGRAM_NAME
	if ARGV.empty?
		reverse_words("reverse_words_file.txt")
	else
		reverse_words("#{ARGV[0]}")
	end
end

