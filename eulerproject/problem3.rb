def largest_prime_factor(number)
	until number <= 1 do 
		2.upto(number) do |num|
			if number % num == 0 && is_a_prime_number?(num)
				number = number / num
				puts num
				break
			end
		end
		largest_prime_factor(number)
	end
end

def is_a_prime_number?(number)
	count = 0
	1.upto(number) do |num|
		if number % num == 0
			count += 1
		end
	end
	count > 2 ? false : true
end

# puts is_a_prime_number?(2)


# puts largest_prime_factor(13195)

puts largest_prime_factor(600851475143)
