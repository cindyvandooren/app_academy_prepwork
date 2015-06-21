def fizzbuzz(file)
	input = []
	content = File.readlines(file)
	content.each do |line|
		line.split(" ").each do |el|
			input << el.chomp.to_i
		end
		translate(input[0], input[1], input[2])
	end	
end

def translate(first_divider, second_divider, counter)
	solution = []
	count = 1
	until solution.size == counter
		if count % first_divider == 0 && count % second_divider == 0
			solution << "FB"
		elsif count % first_divider == 0
			solution << "F"
		elsif count % second_divider == 0
			solution << "B"
		else
			solution << count.to_s
		end
		count += 1
	end
	puts solution.join(" ")
end

if __FILE__ == $PROGRAM_NAME
	if ARGV.empty?
		fizzbuzz("file_for_fizzbuzz.txt")
	else
		fizzbuzz("#{ARGV[0]}")
	end
end