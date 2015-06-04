def rps(choice)
	choices = ['rock', 'paper', 'scissors']
	
	wins = [['rock', 'scissors'], 
			['paper', 'rock'], 
			['scissors', 'paper']]

	return "Your choice is not valid!" unless choices.include?(choice)

	computer_choice = choices[rand(0..2)]
	puts "Computer choses #{computer_choice}"

	if choice == computer_choice
		"There is a tie!"
	else
		wins.include?([choice, computer_choice]) ? "You win!" : "You lose!"
	end
end

def remix(ingredients)
	# gather all the alcohol and all the mixers in separate arrays
	alcohols = ingredients.map { |ingredient_pair| ingredient_pair.first }
	mixers = ingredients.map { |ingredient_pair| ingredient_pair.last }

	# shuffle the mixers array, alcohols does not need to be mixed, you'll get different pairs anyway
	mixers.shuffle!

	# put them back in pairs and return the pairs
	new_drinks = []
	alcohols.each_index { |i| new_drinks << [alcohols[i], mixers[i]] }
	new_drinks
end

# Bonus!!!
def remixer(ingredients)
	# gather all the alcohol and all the mixers in separate arrays
	alcohols = ingredients.map { |ingredient_pair| ingredient_pair.first }
	mixers = ingredients.map { |ingredient_pair| ingredient_pair.last }

	new_drinks = ingredients.dup

	while new_drinks.any? {|new_drink| ingredients.include?(new_drink)}
		mixers.shuffle!
		new_drinks = []
		alcohols.each_index { |i| new_drinks << [alcohols[i], mixers[i]] }
	end
	new_drinks
end


p remixer([['wodka', 'orange'], ['rum', 'cola'], ['safari', 'soda'], ['wine', 'water'], ['beer', 'sprite']])