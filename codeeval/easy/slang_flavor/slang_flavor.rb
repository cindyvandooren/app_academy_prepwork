def slang_flavor(file)
	slang_strings = [", yeah!", ", this is crazy, I tell ya.", ", can U believe this?", ", eh?", ", aw yea.", ", yo.", "? No way!", ". Awesome!"]

	result = ""
	punctuations = [".", "!", "?"]
	# Read the file in one long string
	text = File.read(file)
	# Loop over every element of the string.
	i = 0
	string = 0
	count = 1

	while i < text.size
		if punctuations.include?(text[i])
			if count % 2 == 0
				result << slang_strings[string % 8]
				string += 1
				count += 1
			else
				result << text[i]
				count += 1
			end
		else
			result << text[i]
		end
		i += 1
	end
	puts result
end

if __FILE__ == $PROGRAM_NAME
	if ARGV.empty?
		slang_flavor("slang_flavor.txt")
	else
		slang_flavor("#{ARGV[0]}")
	end
end
