class Student
	def initialize(first_name, last_name)
		@first_name = first_name
		@last_name = last_name
		@course_list = []
	end

	def name
		"#{@first_name} #{@last_name}"
	end

	def courses
		if 	@course_list.empty? 
			"You are not enrolled in a course."
		else
		 @course_list.map {|course| course.course_name}
		end
	end

	def enroll(course)
		if @course_list.include?(course)
			"You are already enrolled in this course."
		elsif self.has_conflict?(course)
			"This course conflicts with your schedule."
		else 
			@course_list << course
			course.enroll_student(self)
			"You are enrolled in #{course.course_name}."
		end
	end

	def unenroll(course)
		if @course_list.include?(course)
			remove_course(course)
			course.remove_student(self)
			"You are unenrolled out of #{course.course_name}"
		else
			"You are not enrolled in this course."
		end
	end

	def remove_course(course)
		@course_list.delete(course)
	end

	def course_load
		load = {}
		@course_list.each do |course|
			if load.keys.include?(course.department)
				load[course.department] += course.credits
			else
				load[course.department] = course.credits
			end
		end
		load
	end

	def has_conflict?(new_course)
		@course_list.any? { |course| course.conflicts_with?(new_course)}
	end
end

class Course
	attr_reader :course_name, :department, :credits, :weekdays, :time_block

	def initialize(course_name, department, credits, weekdays, time_block)
		@course_name = course_name
		@department = department
		@credits = credits
		@weekdays = weekdays
		@time_block = time_block
		@enrolled_students = []
	end

	def students
		@enrolled_students
	end

	def enroll_student(student)
		@enrolled_students << student
	end

	def unenroll_student(student)
		if @enrolled_students.include?(student)
			remove_student(student)
			student.remove_course(self)
			"#{student.name} has been unenrolled from #{self.course_name}."
		else
			"#{student.name} is not enrolled."
		end
	end

	def remove_student(student)
		@enrolled_students.delete(student)
	end

	def conflicts_with?(other_course)
		self.is_on_the_same_day?(other_course) && self.is_on_the_same_time_block?(other_course)
	end

	def is_on_the_same_day?(other_course)
		intersect = other_course.weekdays & @weekdays
		intersect.empty? ? false : true
	end

	def is_on_the_same_time_block?(other_course)
		other_course.time_block == @time_block
	end
end


cindy = Student.new("cindy", "van dooren")
french = Course.new("French", "Languages", 7, [:mon, :wed, :fri], 1)
english = Course.new("English", "Languages", 7, [:thue, :thur], 1)
math = Course.new("Math", "Sciences", 6, [:thue, :thur], 2)
physics = Course.new("Physics", "Sciences", 5, [:thue, :thur], 2)
# puts english.is_on_the_same_day?(french)
# puts english.is_on_the_same_day?(math)
# puts english.is_on_the_same_time_block?(french)
# puts english.is_on_the_same_time_block?(math)
puts english.conflicts_with?(french)
puts english.conflicts_with?(math)
puts math.conflicts_with?(physics)
cindy.enroll(math)
puts cindy.enroll(physics)