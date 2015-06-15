class RPNCalculator
	attr_accessor :stack

	def initialize
		@stack = []
	end

	def push(num)
		@stack << num
	end

	def value
		@stack[-1]
	end

	def plus
		perform_op(:+)
	end

	def minus
		perform_op(:-)
	end

	def divide
		perform_op(:/)
	end

	def times
		perform_op(:*)
	end

	def perform_op(symbol)
		raise "calculator is empty" unless @stack.size >= 2

		right_operand = @stack.pop
		left_operand = @stack.pop

		case symbol
		when :+
			@stack << left_operand + right_operand
		when :-
			@stack << left_operand - right_operand
		when :/
			@stack << left_operand.to_f / right_operand.to_f
		when :* 
			@stack << left_operand * right_operand
		else
			@stack << left_operand << right_operand
			raise ArgumentError.new("No operation #{op_sym}")
		end
	end


	def tokens(string)
		tokenized_string = []
		operators = { "+" => :+, "-" => :-, "/" => :/, "*" => :* }
		string.split.each do |el|
			operators.keys.include?(el) ? tokenized_string << operators[el] : tokenized_string << el.to_i
		end
		tokenized_string
	end

	def evaluate(string)
		tokens(string).each do |el|
			if el.is_a?(Symbol)
				perform_op(el)
			elsif el.is_a?(Integer)
				push(el)
			end
		end
		value
	end

	def self.prompt
		puts "Please enter a number or operator (ENTER to quit)"
		print "> "
	end

	def self.run_ui
		calc = RPNCalculator.new
		string = ""

		loop do
			prompt
			input = gets.chomp
			break if input.empty?
			string << " #{input}"
		end

		puts calc.evaluate(string)
	end

	def self.evaluate_file(file)
		file.each do |line|
			line = line.chomp
			calc = RPNCalculator.new
			puts calc.evaluate(line)
		end
	end
end

if __FILE__ == $PROGRAM_NAME
	# only run this in program mode
	if ARGV.empty?
		# if no file is given, read the input from the console
		RPNCalculator.run_ui
	else
		File.open(ARGV[0]) do |file|
			puts RPNCalculator.evaluate_file(file)
		end
	end
end

=begin
Questions I had about this code:
I am revising this week’s work and when I look at the solution of the RPN Calculator, there are a few things that I 
don’t understand:
- Why do we start a new RPNCalculator on line 7? Why do we do that inside the RPNCalculator class? 
Why don’t we start one on line 113 and line 110 right before we call methods that are inside the RPNCalculator class?
- Why do we use self for the evaluate_file, prompt and ui methods?

Answer: 
@cindyvandooren: I'm going to answer your last question first.  Let's look at `evaluate_file` and `run_ui`. These are both class methods which instantiate a `RPNCalculator` object. The reason that they're class methods is because they don't depend on the state of a given *instance* of a class. If we didn't define them with `self`, we would need to first instantiate an RPN Calculator before we could call these methods. But since the whole purpose of these methods is to *create* an instance of the class, it makes sense to define them as class methods. (edited)

easchwar [2:17 PM]
Since our RPN Calculator can be run 2 different ways (either with a file passed in or by using the terminal input), we need two different ways of running it (`evalutate_file` and `run_ui`). We could have put the logic of these two methods in our `if` statement on line 108, but since this is logic we may want to use elsewhere, it makes sense to encapsulate them in methods that we can call anywhere

easchwar [2:20 PM]
and the reason we don't instantiate new RPN Calculators on lines 113 and 110 is because we wrote our class methods to do that for us. (edited)

easchwar [2:24 PM]
I hope this helps! It's a tricky topic so let me know if that was an unsatisfactory answer





=begin
This was the first try of the evaluate method. We ran into some trouble while building it.
The explanation for this can be found underneath the method. 
def evaluate(string)
  #send string to tokenize
  operators = { :+ => :plus, :- => :minus, :/ => :divide, :* => :times}
    tokenized = tokens(string).reverse
    #push all values in array to calculator - if value is a symbol, make that
    #an operator specific call.
    tokenized.length.times do 
      var = tokenized.pop
       if var.is_a? Float
          @calculator.push(var)
       else
        # TA: `self.send(:plus)` is the same as calling `plus`
        self.send(operators[var])
       end
    end
    #return value
    self.value
end
=end
# At first the code in evaluate didn't work, because we wrote a hash operators like this: 
# operators = {:+ => plus, :- => minus, :/ => divide, :* => times}
# Then in tokenized.length.times do we put in the else statement: 
# @calculator.(operators[var])
# We were trying to point symbols to methods inside of the hash. 
# But when you write plus without any string or symbol syntax, then the 
# method is called inside the hash. At that point the calculator is still empty, because
# we didn't add any tokens to it yet.
# That is why we got a calculator is empty error. 
# The solution is to send a message to our calculator. We change the hash to symbols, see in code
# on line 79. Then we use send on the calculator to call those methods later. 
# The only problem is that @calculator is an array and arrays don't have the plus method.
# That is why it has to be called on self.
# Also a Float is not a Fixnum. A float is an instance of class Float.

