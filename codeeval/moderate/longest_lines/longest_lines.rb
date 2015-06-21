def longest_lines(file)
	lines = File.readlines(file)
	number = lines.shift.chomp.to_i
	determine_longest_lines(number, lines)
end

def determine_longest_lines(num, lines)
	sorted_lines = lines.sort_by { |l| l.size }
	result = []
	num.times do 
		result << sorted_lines.pop
	end
	result.each { |l| puts l}

end

if __FILE__ == $PROGRAM_NAME
	if ARGV.empty?
		longest_lines("longest_lines.txt")
	else
		longest_lines("#{ARGV[0]}")
	end
end

