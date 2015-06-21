def compare_points(file)
	lines = File.readlines(file)
	lines.each do |l| 
		a = l.chomp.split(" ")
		puts determine_direction(a[0].to_i, a[1].to_i, a[2].to_i, a[3].to_i)
	end
end

def determine_direction(p1, p2, d1, d2)
	result = []
	if p1 == d1 && p2 == d2
		result << "here"
	elsif d1 - p1 < 0
		result << "N"
	elsif d1 - p1 > 0
		result << "S"
	end

	if d2 - p2 > 0
		result << "E"
	elsif 
		d2 - p2 < 0
		result << "W"
	end

	result.join("")
end


if __FILE__ == $PROGRAM_NAME
	if ARGV.empty? 
		compare_points("compare_points_file.txt")
	else
		compare_points("#{ARGV[0]}")
	end
end