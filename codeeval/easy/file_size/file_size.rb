def file_size(file)
	puts File.size(file)
end

if __FILE__ == $PROGRAM_NAME
	if ARGV.empty?
		file_size("file_size_file.txt")
	else
		file_size("#{ARGV[0]}")
	end
end
			