def prime_palindrome(number)
	number.downto(1).each do |num|
		if is_a_palindrome?(num) && is_a_prime?(num)
			return num
		end
	end
end


def is_a_palindrome?(number)
	number.to_s == number.to_s.reverse
end

def is_a_prime?(number)
	count = 0
	1.upto(number) do |num|
		if number % num == 0
			count += 1
		end
	end
	count <= 2 ? true : false
end

puts prime_palindrome(1000)