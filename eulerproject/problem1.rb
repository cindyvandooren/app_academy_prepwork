def multiples(number)
	multiples = []
	(1...number).each do |number|
		if number % 3 == 0 || number % 5 == 0
			multiples << number
		end
	end
	multiples.inject(0) { |sum, number| sum += number }
end

puts multiples(1000)
