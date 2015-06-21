

def knight_moves(file)
	lines = File.readlines(file)
	lines.each do |line|
		puts find_positions(line)
	end
end

def find_positions(line)
	org_pos = translate_to_pos(line)
	new_pos = all_possible_positions(org_pos)
	result = translate_from_pos(new_pos)
	result.sort.join(" ")
end

def translate_to_pos(line)
	tr_l = {"a" => 0, 
		      "b" => 1, 
	  	    "c" => 2, 
	    	  "d" => 3, 
	        "e" => 4, 
	        "f" => 5, 
	        "g" => 6, 
	        "h" => 7
	        }
	tr_n = {"1" => 7,
	        "2" => 6,
	      	"3" => 5,
	      	"4" => 4,
	      	"5" => 3,
	      	"6" => 2,
	      	"7" => 1,
	      	"8" => 0
	       }

	coordinates = line.chomp.split("")
	org_pos = [tr_l[coordinates[0]], tr_n[coordinates[1]]]
end


def all_possible_positions(pos)
	all_positions = [[pos[0] - 2, pos[1] + 1],
									 [pos[0] - 2, pos[1] - 1],
									 [pos[0] - 1, pos[1] - 2],
									 [pos[0] + 1, pos[1] - 2],
									 [pos[0] - 1, pos[1] + 2],
									 [pos[0] + 1, pos[1] + 2],
									 [pos[0] + 2, pos[1] - 1],
									 [pos[0] + 2, pos[1] + 1]
									]
	all_pos = []
	all_positions.each do |p|
		if p[0].between?(0,7) && p[1].between?(0,7)
			all_pos << p
		end
	end
	all_pos
end

def translate_from_pos(pos)
	tr_l = {"a" => 0, 
		      "b" => 1, 
	  	    "c" => 2, 
	    	  "d" => 3, 
	        "e" => 4, 
	        "f" => 5, 
	        "g" => 6, 
	        "h" => 7
	        }
	tr_n = {"1" => 7,
	        "2" => 6,
	      	"3" => 5,
	      	"4" => 4,
	      	"5" => 3,
	      	"6" => 2,
	      	"7" => 1,
	      	"8" => 0
	       }

	result = []
	pos.each do |p|
		result << "#{tr_l.key(p[0])}#{tr_n.key(p[1])}"
	end
	result
end


if __FILE__ == $PROGRAM_NAME
	if ARGV.empty?
		knight_moves("knight_moves_file.txt")
	else
		knight_moves("#{ARGV[0]}")
	end
end




