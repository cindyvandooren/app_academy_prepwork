
def fibonacci(max)
	fibonacci = [1, 2]
	while fibonacci[-1] + fibonacci[-2] <= max
		fibonacci << fibonacci[-1] + fibonacci[-2]
	end
	fibonacci.select! { |el| el % 2 == 0}
	fibonacci.inject(0) { |sum, number| sum += number }
end

puts fibonacci(4000000)