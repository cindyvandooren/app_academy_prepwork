def my_uniq(arr)
	uniq_arr = []
	arr.each_with_index do |element, index|
		if arr.index(element) == index
			uniq_arr << element
		end
	end
	uniq_arr
end

class Array
	def my_uniq
		uniq_arr = []
		self.each_with_index do |element, index|
			if self.index(element) ==  index
				uniq_arr << element
			end
		end
		uniq_arr
	end
end

def two_sum(arr)
	pairs_arr = []
	arr.each_with_index do |element, index|
		if arr.include?(-element)
			if index < arr.index(-element)
				pairs_arr << [index, arr.index(-element)]
			end
		end
	end
	pairs_arr
end

def my_transpose(matrix)
	transpose_matrix = []
	matrix.count.times { transpose_matrix << [] }
	
	# iterate over each row in the existing matrix
	matrix.each_with_index do |row, row_index|
		# then iterate over each element of the row in the existing matrix
		row.each_with_index do |row_element, column_index|
			# add the element of each row, to the new column arrays in the transpose matrix
			transpose_matrix[column_index] << row_element
		end
	end
	transpose_matrix
end

def stock_picker(stock_prices)
	highest_profit = 0
	buying_day = nil
	selling_day = nil

	stock_prices.each_with_index do |buying_pr, buying_d|
		stock_prices.each_with_index do |selling_pr, selling_d|
			if buying_d < selling_d
				profit = selling_pr - buying_pr
				if profit > highest_profit
					highest_profit = profit
					buying_day = buying_d
					selling_day = selling_d
				end
			end
		end
	end
	puts "The best day for buying is #{buying_day}, the best day for selling is #{selling_day}" 
end











