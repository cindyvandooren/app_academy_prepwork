def minimum_distance(file)
	lines = File.readlines(file)
	lines.each do |l|
		new_line = l.chomp.split(" ")
		new_line.map! { |el| el.to_i }
		puts calculate_minimum_distance(new_line)
	end
end

def calculate_minimum_distance(l)
	number_of_houses = l.shift
	houses = l
	if number_of_houses % 2 == 0
		i1 = (number_of_houses / 2) - 1
		i2 = number_of_houses / 2
		h = (houses[i1] + houses[i2]) / 2
	else
		h = houses[number_of_houses / 2]
	end

	houses.inject(0) { |s, n| s += (h- n).abs}


end

if __FILE__ == $PROGRAM_NAME
	if ARGV.empty?
		minimum_distance("minimum_distance_file.txt")
	else
		minimum_distance("#{ARGV[0]}")
	end
end
