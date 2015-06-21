def odd_numbers(number)
	1.upto(number) do |num|
		if num % 2 == 1
			puts num
		end
	end
end

odd_numbers(99)