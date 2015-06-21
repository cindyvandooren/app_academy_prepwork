def prime_numbers(file)
	lines = File.readlines(file)
	lines.each do |line|
		number = line.chomp.to_i
		puts print_prime_numbers(number)
	end
end

def is_a_prime?(num)
	return false if num == 1
	return true if num == 2

	2.upto(num - 1) do |n|
		if num % n == 0
			return false
		end
	end
	true
end

def print_prime_numbers(num)
	result = []
	1.upto(num) do |n|
		if is_a_prime?(n)
			result << n
		end
	end
	result.join(",")
end

if __FILE__ == $PROGRAM_NAME
	if ARGV.empty?
		prime_numbers("prime_numbers.txt")
	else
		prime_numbers("#{ARGV[0]}")
	end
end
