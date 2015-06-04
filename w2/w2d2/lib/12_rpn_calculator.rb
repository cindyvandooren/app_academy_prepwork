# require 'byebug'

class RPNCalculator
  # TODO: your code goes here!
    attr_accessor :calculator
    
    def initialize
        @calculator = []
    end
    
    def push(var)
       @calculator << var
    end
    
    def check_error?
        if @calculator.empty?
            raise "calculator is empty"
        elsif @calculator.size < 2
            raise "Not enough in the stack to make a calculation"
        end
        true
    end
    
    def plus
      if self.check_error?
        #pop two most recent values off of the stack and then add them
        @calculator << @calculator.pop + @calculator.pop
      end
    end
    
    def minus
      if self.check_error?
        #pop two most recent values off of the stack and then subtract them
        second = @calculator.pop
        first = @calculator.pop
        @calculator << first - second
      end
    end
    
    def divide
      if self.check_error?
        #pop two most recent values off of the stack and then divide them
        second = @calculator.pop
        first = @calculator.pop
        if second == 0 
          raise "You cannot divide by zero."
        else
          @calculator << first.to_f / second.to_f
        end
      end
    end
    
    def times
      if self.check_error?
        #pop two most recent values off of the stack and then multiply them
        @calculator << @calculator.pop * @calculator.pop
      end
    end
    
    def value
       @calculator[-1]
    end
    
    def tokens(string)
      tokenized = []
      operators = ["+", "-", "/", "*"]
      string.split(" ").each do |value|
        if operators.include?(value)
          tokenized << value.to_sym
        else
          tokenized << value.to_f
        end
      end
      tokenized
    end
    
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
end
