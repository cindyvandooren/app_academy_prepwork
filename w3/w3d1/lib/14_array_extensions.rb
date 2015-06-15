class Array
	def sum
		self.inject(0) {|sum, num| sum += num}
	end

	def square
		self.map { |el| el * el }
	end

	def square!
		self.map! { |el| el * el }
	end
end
