class Rps
	RoPaSc = { 0 => "rock", 1 => "paper", 2 => "scissors" }

	def initialize(level)
		@level = level
	end

	def move(move)
		a = RoPaSc[rand(0..2)]
		puts "Computer picks #{a}"
		if move == a
			"Tie"
		else
			if move == 'rock'
				if a == 'paper'
					"Computer wins"
				elsif a == 'scissors'
					"You win"
				end
			elsif move == 'scissors'
				if a == 'paper'
					"You win"
				elsif a == 'rock'
					"Computer wins"
				end
			elsif move == 'paper'
				if a == 'rock'
					"You win"
				elsif a == 'scissors'
					"Computer wins"
				end
			end
		end
	end
end


game = Rps.new(1)
puts game.move('rock')