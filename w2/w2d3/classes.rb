class Student

	def initialize(first_name, last_name)
		@first_name = first_name
		@last_name = last_name
		@course_list = []
	end

	def name
		"#{first_name} #{last_name}"
	end

	def courses
		puts @course_list
	end

	def enroll(course)
		@course_list << course unless @course_list.include?(course)
	end

	def course_load
	end


end

class Course
	attr_reader :name, :department, :credits

	def initialize(name, department, credits)
		@name = name
		@department = department
		@credits = credits
	end

	def students
	end

	def add_student
	end
end

cindy = Student.new("cindy", "van dooren")


cindy.enroll(Course.new("wiskunde", "ict", 1))

cindy.courses
