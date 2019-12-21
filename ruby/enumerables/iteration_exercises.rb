# Review the iteration exercises from the prepwork. Implement the following methods:
  #factors(num)
  #bubble_sort!(&prc)
  #bubble_sort(&prc)
  #substrings(string)
  #subwords(word, dictionary)

def factors(num)
  factors = (1..num.abs).select { |factor| num % factor == 0 }
    # include negative numbers 
  factors += factors.map { |factor| -factor }
end