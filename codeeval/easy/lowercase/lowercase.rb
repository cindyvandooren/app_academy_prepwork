def lowercase(file)
	lines = File.readlines(file)
	lines.each do |line|
		puts line.chomp.downcase
	end
end

if __FILE__ == $PROGRAM_NAME
	if ARGV.empty?
		lowercase("lowercase.txt")
	else
		lowercase("#{ARGV[0]}")
	end
end