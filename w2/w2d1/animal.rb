class Human
	attr_accessor :hair_colour, :has_mail, :is_mailman

	def initialize(age)
		@age = age
	end
end

class Man < Human
	def initialize(has_piemel)
		@has_piemel = has_piemel
	end
end

class Woman < Human
	def initialize(has_tieten)
		@has_tieten = has_tieten
	end
end

class Mailman < Human
end

a = Mailman.new(27)
a.has_mail
a.has_piemel


