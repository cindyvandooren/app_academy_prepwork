def penultimate_word(file)
	lines = File.readlines(file)
	lines.each do |line|
		puts line.chomp.split(" ")[-2]
	end
end

if __FILE__ == $PROGRAM_NAME
	if ARGV.empty?
		penultimate_word("penultimate_word.txt")
	else
		penultimate_word("#{ARGV[0]}")
	end
end
