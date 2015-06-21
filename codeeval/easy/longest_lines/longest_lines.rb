def longest_lines(file)
	content = File.readlines(file)
	content
end

longest_lines("file_for_longest_lines.txt")