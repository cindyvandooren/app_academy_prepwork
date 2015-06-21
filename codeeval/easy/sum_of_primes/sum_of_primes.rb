def sum_of_primes(number)
	primes = []
	count = 1
	until primes.size == number
		count += 1
		if is_a_prime?(count)
			primes << count
		end
	end
	primes.inject(0) { |sum, num| sum += num }
end

def is_a_prime?(number)
	count = 0
	1.upto(number) do |num|
		if number % num == 0
			count +=1
		end
	end
	count <= 2 ? true : false
end

puts sum_of_primes(1000)
