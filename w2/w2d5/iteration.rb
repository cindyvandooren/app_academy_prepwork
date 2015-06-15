require 'byebug'

def factors(num)
	(1..num).to_a.select { |factor| num % factor == 0 }
end

def bubblesort(arr)
	arr.size.times do 
		arr.each_with_index do |element, index|
			if index < arr.size - 1
				if arr[index] > arr[index+1]
					arr[index], arr[index+1] = arr[index+1], arr[index]
				end
			end
		end
	end
	arr
end

def substring(string)
	substrings = []
	(0..string.length-1).each do |start_index|
		(1..string.length-start_index).each do |slice_size|
				substring = string.slice(start_index, slice_size)
				substrings << substring unless substrings.include?(substring)
		end
	end
	substrings
end


def subwords(string)
	subwords = []
	substrings = substring(string)
	dictionary = File.readlines("dictionary.txt")
	dictionary.map! { |word| word.chomp }
	substrings.each do |substring|
		if dictionary.include?(substring)
			subwords << substring
		end
	end
	subwords
end

puts subwords("yetizesty")

