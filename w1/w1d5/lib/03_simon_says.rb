def echo(string)
  string
end

def shout(string)
  string.upcase
end

def repeat(string, num = 2)
  ("#{string} " * num).strip
end

def start_of_word(string, num)
  string[0...num]
end

def first_word(sentence)
  sentence.split[0]
end

def titleize(sentence)
  result = []
  little_words = ["and", "or", "the", "over"]
  sentence.split.each_with_index do |word, index|
    (index == 0 || !little_words.include?(word)) ? 
                result << word.capitalize : result << word
  end
  result.join(" ")
end





