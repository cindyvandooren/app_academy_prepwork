def num_to_s(num, base)
    conversion = { 0 => "0", 1 => "1", 2 => "2", 3 => "3", 4 => "4", 5 => "5", 
                   6 => "6", 7 => "7", 8 => "8", 9 => "9", 10 => "A", 11 => "B",
                   12 => "C", 13 => "D", 14 => "E", 15 => "F" }
    pow = 0
    
    result = ""
    return "0" if num == 0

    until num / (base ** pow) == 0 do
        key = ((num / (base ** pow )) % base)
        result << conversion[key]
        pow += 1
    end    
    result.reverse
end

def caesar_cipher(string, base)
    result = ""
    string.split(/\s*?/).each do |letter|

        ascii_value = ((letter.ord - 96 + base) % 26) + 96

        result << ascii_value.chr
    end
    result
end




