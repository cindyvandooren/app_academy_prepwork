def even_numbers(file)
	lines = File.readlines(file)
	lines.each do |line|
		number = line.chomp.to_i
		if number % 2 == 0
			puts 1
		else
			puts 0
		end
	end
end

if __FILE__ == $PROGRAM_NAME
	if ARGV.empty?
		even_numbers("even_numbers.txt")
	else
		even_numbers("#{ARGV[0]}")
	end
end