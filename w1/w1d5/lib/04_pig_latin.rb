def translate(sentence)
  result = []
  words = sentence.split(" ")
  words.each_with_index do |word, index|
    word == word.capitalize ? 
          result << translate_word(word.downcase).capitalize : result << translate_word(word.downcase)
  end
  result.join(" ")
end

def translate_word(word)
  vowels = %w[a e i o u]
  start_index = 0
  end_index = -1
  second_start_index = nil
  last_character = word[-1]
  
  # Iterate through all the letters of the word.
  # When we arrive at the first vowel set that index to be the start index of the
  # new string
  0.upto(word.length - 1) do |index|
      if vowels.include?(word[index])
        start_index = index
        second_start_index = 0
        break
      elsif word[index] == "q" && word[index + 1] == "u"
        start_index = index + 2
        second_start_index = 0
        break
      end
  end 
  
  if %w[ : , ! ? . ;].include?(last_character)
    end_index = -2
  end
  
  "#{word[start_index..end_index]}#{word[second_start_index...start_index]}ay" + 
    (end_index < -1 ? word[-1] : "")
end

