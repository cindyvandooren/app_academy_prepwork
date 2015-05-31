def add(num1,num2)
  num1 + num2
end

def subtract(num1,num2)
  num1 - num2
end

def sum(arr)
  arr.inject(0) {|sum, element| sum += element}
end

def multiply(*nums)
  nums.inject(1) {|product, num| product *= num }
end

def power(num1, num2)
  num1 ** num2
end

def factorial(num1)
  num1 == 0 || num1 == 1 ? 1 : num1 * factorial(num1 - 1)
end
