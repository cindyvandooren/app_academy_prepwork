class Dictionary
	attr_accessor :entries

	def initialize
		@entries = {}
	end

	def add(entry)
		if entry.is_a?(Hash)
			entry.each do |key, value|
				@entries[key] = value
			end
		else
			@entries[entry] = nil
		end
	end

	def keywords
		@entries.keys.sort
	end

	def include?(word)
		keywords.include?(word)
	end

	def find(string)
		result = {}
		keywords.each do |keyword|
			if keyword.start_with?(string)
				result[keyword] = @entries[keyword]
			end
		end
		result
	end

	def printable
		print = []
		keywords.each do |keyword|
			print << "[#{keyword}] \"#{@entries[keyword]}\""
		end
		print.join("\n")
	end

end

