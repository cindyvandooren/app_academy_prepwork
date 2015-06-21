def string_mask(file)
	File.readlines(file).each do |line|
		puts translate(line)
	end
end

def translate(line)
	word = line.split(" ")[0].chomp.split("")
	digits = line.split(" ")[1].chomp.split("")

	digits.each_with_index do |digit, index|
		if digit == "1"
			word[index] = word[index].upcase
		elsif digit == "0"
			word[index] = word[index].downcase
		end
	end
	word.join("")
end


if __FILE__ == $PROGRAM_NAME
	if ARGV.empty?
		string_mask("string_mask_file.txt")
	else
		string_mask("#{ARGV[0]}")
	end
end
