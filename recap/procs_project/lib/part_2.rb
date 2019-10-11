def reverser(str, &prc)
  prc.call(str.reverse)
end

def word_changer(sentence, &prc)
  changed = sentence.split.map { |word| prc.call(word) }

  changed.join(" ")
end

def greater_proc_value(num, prc_1, prc_2)
  [prc_1.call(num), prc_2.call(num)].max
end

def and_selector(arr, prc_1, prc_2)
  arr.select { |ele| prc_1.call(ele) && prc_2.call(ele) }
end

def alternating_mapper(arr, prc_1, prc_2)
  arr.map.with_index do |ele, i|

    if i.even?
      prc_1.call(ele)
    else
      prc_2.call(ele)
    end
    
  end
end