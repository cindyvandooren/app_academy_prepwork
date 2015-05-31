# Write a method that takes an array of integers and returns an array
# with the array elements multiplied by two.
def times_two(arr)
	arr.map{|i| i * 2}
end

# Extend the Array class to include a method named my_each that takes a block,
# calls the block on every element of the array, and then returns the original
# array. Do not use Ruby's Enumerable each method.
class Array
	def my_each
		l = 0
		while l < self.count
			yield(self[l])
			l += 1
		end
		self
	end
end

# Write a method that finds the median of a given array of integers. If the array
# has an odd number of integers, return the middle item from the sorted array. If 
# the array has an even number of integers, return the average of the middle two
# items from the sorted array. 
def median(arr)
	sorted_arr = arr.sort
	count = sorted_arr.count 
	if sorted_arr.empty?
		"There is no median"
	elsif count % 2 == 0
		(sorted_arr[count / 2] + sorted_arr[(count / 2) -1 ])/2.0
	else
		sorted_arr[count / 2]
	end
end

# Create a method that takes in an Array of Strings and uses inject to return
# the concatenation of the strings.
def concatenate(arr)
	arr.inject(""){|start, word| start += word}
end


