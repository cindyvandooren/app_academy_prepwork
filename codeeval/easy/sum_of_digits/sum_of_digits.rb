def sum_of_digits(file)
	lines = File.readlines(file)
	lines.each do |line|
		puts calculate_sum(line)
	end
end

def calculate_sum(line)
	digits = line.chomp.split("").map!{ |l| l.to_i }
	digits.inject(0) { |s,n| s+= n }
end


if __FILE__ == $PROGRAM_NAME
	if ARGV.empty?
		sum_of_digits("sum_of_digits.txt")
	else
		sum_of_digits("#{ARGV[0]}")
	end
end
