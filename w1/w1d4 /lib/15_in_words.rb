class Fixnum
  Single_digits = { 0 => "zero", 1 => "one", 2 => "two", 3 => "three", 4 => "four", 5 => "five", 
                      6 => "six", 7 => "seven", 8 => "eight", 9 => "nine"}
    
  Teens = { 10 => "ten", 11 => "eleven", 12 => "twelve", 13 => "thirteen", 14 => "fourteen",
              15 => "fifteen", 16 => "sixteen", 17 => "seventeen", 18 => "eighteen",
              19 => "nineteen" }
              
  Tens = { 20 => "twenty", 30 => "thirty", 40 => "forty", 50 => "fifty", 60 => "sixty",
             70 => "seventy", 80 => "eighty", 90 => "ninety" }
  
  def in_words
    if self > 999_999_999_999
      tr = self / 1_000_000_000_000
      b = self % 1_000_000_000_000
      b == 0 ? "#{tr.hundreds} trillion" : "#{tr.hundreds} trillion #{b.billions}"
    else
      self.billions
    end
  end
  
  def billions
    if self > 999_999_999
      b = self / 1_000_000_000
      m = self % 1_000_000_000
      m == 0 ? "#{b.hundreds} billion" : "#{b.hundreds} billion #{m.millions}"
    else
      self.millions
    end
  end
  
  def millions
    if self > 999_999
      m = self /  1_000_000
      th = self % 1_000_000
      th == 0 ? "#{m.hundreds} million" : "#{m.hundreds} million #{th.thousands}"
    else
      self.thousands
    end
  end
  
  def thousands
    if self > 999
      th = self / 1000
      h = self % 1000
      h == 0 ? "#{th.hundreds} thousand" : "#{th.hundreds} thousand #{h.hundreds}"
    else
      self.hundreds
    end
  end
  
  def hundreds
    if self > 99
      h = self / 100
      t = (self % 100)
      t == 0 ? "#{Single_digits[h]} hundred" : "#{Single_digits[h]} hundred #{t.up_to_hundred}"
      
    else
      self.up_to_hundred
    end
  end
  
  def up_to_hundred
    if self > 19
      t = (self / 10) * 10
      s = self % 10
      s == 0 ? Tens[t] : "#{Tens[t]} #{Single_digits[s]}"
    elsif self > 9
      Teens[self]
    else
      Single_digits[self]
    end
  end
end
