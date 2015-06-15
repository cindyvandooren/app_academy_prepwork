
def super_print(string, options={})
	defaults = {
		:times => 1,
		:upcase => false,
		:reverse => false,
	}

	options = defaults.merge(options)

	new_string = ("#{string} " * options[:times]).strip

	if options[:upcase]
		new_string = new_string.upcase
	end

	if options[:reverse]
		new_string = new_string.reverse
	end

	puts new_string
end

options = {:times => 5, :upcase => true, :reverse => true}
super_print("hello", options)

