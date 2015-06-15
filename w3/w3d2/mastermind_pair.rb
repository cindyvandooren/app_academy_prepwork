class Game
  def initialize
    @secret = Code.random
    @steps = 0
  end
  
  def turn
    @steps += 1
    guess = nil
    until guess != nil 
      print "Please input your code: "
      guess = Code.parse(gets.chomp)
    end
    near = guess.near_matches(@secret)
    exact = guess.exact_matches(@secret)
    puts "#{near} near matches"
    puts "#{exact} exact matches"
    exact == 4
  end
  
  def play
    has_won = false
    until has_won || @steps >= 10
      has_won = turn
    end
    if has_won
      puts "You've won in #{@steps} turns."
    else
      puts "Sorry, you lose.  Please try again."
    end
  end
end

class Code
  attr_reader :sequence

  Color = ['R','G','B','Y','O','P']

  def initialize(seq)
    @sequence = seq
  end
  
  def self.random
    seq = []
    4.times do
      seq << Color[rand(6)]
    end
    self.new(seq)
  end
  
  def self.parse(text)
    seq = text.split('')
    if seq.size != 4
      puts "Invalid input, must be 4 characters."
      return nil
    end
    if not seq.all? {|chr| Color.include?(chr)}
      puts "Invalid input #{text}, not all characters are valid colors."
      return nil
    end
    self.new(seq)
  end
  
  def each
    @sequence.each {|x| yield x}
  end
  
  def include?(x)
    @sequence.include?(x)
  end
  
  def near_matches(other)
    count = 0
    self.each do |this|
      if other.include?(this)
        count += 1
      end
    end
    count
  end
  
  def exact_matches(other)
    count = 0
    (0..3).each do |i|
      if @sequence[i] == other.sequence[i]
        count += 1
      end
    end
    count
  end
end


