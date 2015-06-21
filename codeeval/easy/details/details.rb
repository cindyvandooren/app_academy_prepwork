def details(file)
	matrices = File.readlines(file).map! { |l| l.chomp.split(",")}
	matrices.each do |matrix|
		read_details(matrix)
	end
end

def read_details(matrix)
	lines = matrix.map! { |l| l.chomp.split("") }
	# p lines

	smallest_step = lines[0].size
	# p smallest_step

	# Find the first occurrence of y and the last occurence of x in every line
		lines.each_with_index do |line, index|
			# puts "line is #{line}, index is #{index}"
			first_y = nil
			last_x = nil
			line.each_with_index do |el, index|
				# puts "el for y = #{el}, index is #{index}"
				if el == "Y"
					first_y = index
					# puts "first_y is #{first_y}"
					break
				end
			end
			line.reverse.each_with_index do |el, index|
				# puts "el for x is #{el}, index is #{index}"
				if el == "X"
					last_x = lines[0].size - 1 - index
					# puts "last_x is #{last_x}"
					break
				end
			end
			if first_y - last_x - 1 < smallest_step
				smallest_step = first_y - last_x - 1
			end
		end
		puts smallest_step
	end


if __FILE__ == $PROGRAM_NAME
	if ARGV.empty?
		details("details_file.txt")
	else
		details("#{ARGV[0]}")
	end
end


