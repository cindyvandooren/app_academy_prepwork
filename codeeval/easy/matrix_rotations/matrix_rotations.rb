def matrix_rotations(file)
	# Read the file
	lines = File.readlines(file)
	lines.each do |line|
		matrix = make_matrix(line)
		transposed_matrix = transpose(matrix)
		new_line = make_line(transposed_matrix)
		puts new_line
	end
end

def make_matrix(line)
	arr = line.chomp.split(" ")
	matrix_size = (arr.size ** 0.5).to_i
	matrix = Array.new(matrix_size) {Array.new(matrix_size)}
	(0...matrix_size).each do |row|
		(0...matrix_size).each do |col|
			matrix[row][col] = arr.shift
		end
	end
	matrix
end

def transpose(matrix)
	new_matrix = Array.new(matrix.size) {Array.new(matrix.size)}
	# The row index from the new matrix is equal to the column index from the old matrix
	(0...matrix.size).each do |row|
		(0...matrix.size).each do |col|
			new_matrix[row][col] = matrix[matrix.size - 1 - col][matrix.size - 1 - row]
		end
	end
	new_matrix.reverse
end

def make_line(transposed_matrix)
	result = []
	transposed_matrix.each do |line|
		line.each do |el|
			result << el
		end
	end
	result.join(" ")
end


if __FILE__ == $PROGRAM_NAME
	if ARGV.empty?
		matrix_rotations("matrix_rotations.txt")
	else
		matrix_rotations("#{ARGV[0]}")
	end
end
