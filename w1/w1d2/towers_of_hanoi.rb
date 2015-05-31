## sudo cod (not real code, but a sketch of what should happen)
=begin
> boolean (is it solved?)
> def a fuction to check if it's solved
> give a score (perfect game = 2 * discs) [low priority]

loop #1 - ask the player how hard to make the game (set up)

loop #2 -
 a ) puts the current state of the game
 b ) ask the player what you want to do
 c ) do it
 d ) check if it's done

=end

solved = false

def is_solved? (tower1, tower2, tower3)
  if !(tower1.empty? and tower2.empty?)
    return false
  else
    (0...tower3.length).each do |i|
      if tower3[tower3.length-i-1] != (i+1)
        return false
      end
    end
  end
  return true
end

def print_state (tower1, tower2, tower3)
  puts "base <== ==> top"
  puts "tower1 " + tower1.to_s
  puts "tower2 " + tower2.to_s
  puts "tower3 " + tower3.to_s
  puts ""
end




tower1 = []
tower2 = []
tower3 = []

round_count = 1

puts "== Towers of Henoi =="
##loop 1
until tower1.length > 0 do
  puts ""
  print "please choose your difficulty: (integer, number of stacks)"
  input = gets.chomp
  if (input.to_i > 0)
    tower1 = []
    input.to_i.times { |x| tower1.insert(0, x+1) } #adds integers into the tower1 array
  else
    puts "only positive integers are accepted!"
  end
end

##loop 2
until solved do #same as while (not solved)

  print_state(tower1, tower2, tower3)
  puts "Round #{round_count}"
  input1 = input2 = []
  
  while input1.empty?
    print "Which disc would you like to move?  "
    input1 = eval("tower" + gets.chomp)
    if input1.empty?
      puts "This tower is empty. Choose another disc."
    end
  end
  moving_disc = input1.last
  puts "you selected disk of size: #{moving_disc}"
  puts ""
  print "Where do you want to move it to?  "
  input2 = eval("tower" + gets.chomp)
  if input2.empty? || (input2.last > moving_disc)
    input2 << input1.pop
    round_count += 1
  else input2.last < moving_disc
    puts "You cannot put a larger disk on top of a smaller disk"
    puts ""
  end
  
  #input2 == 1000 ? solved = true : nil
  
#a lot of more code
  solved = is_solved?(tower1, tower2, tower3)
end

print_state(tower1, tower2, tower3)
puts ""
puts "CONGRATULATIONS! Puzzle solved!"
puts "You took #{round_count} rounds!"
if round_count <= 2*(tower3.length)+ 1
  puts "You're a genius! You found the optimal solution!"
else
  puts "You took more steps than the optimal solution."
  puts "Compare your count with the optimal solution, which took only #{2*(tower3.length)+ 1} rounds."
end