# A palindromic number reads the same both ways. 
# The largest palindrome made from the product of two 2-digit numbers is 
# 9009 = 91 × 99.
# Find the largest palindrome made from the product of two 3-digit numbers.

def largest_palindrome
	largest_palindrome = 1

	999.downto(1) do |first_number|
		999.downto(1) do |second_number|
			product = first_number * second_number
			if is_a_palindrome?(product)
				if product > largest_palindrome
					largest_palindrome = product
				end
			end
		end
	end
	largest_palindrome
end

def is_a_palindrome?(number)
	string = number.to_s
	string == string.reverse
end

puts largest_palindrome