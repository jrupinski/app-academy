require "byebug"

# phase_1
def some?(arr, &block)
  arr.each { |ele| return true if block.call(ele) }
  false
end

def exactly?(arr, n, &block)
  count = 0
  arr.each { |ele| count += 1 if block.call(ele) }
  count == n
end

def filter_out(arr, &block)
  filtered = []
  arr.each { |ele| filtered << ele if block.call(ele) == false}
  filtered
end

def at_least?(arr, n, &block)
  count = 0
  arr.each { |ele| count += 1 if block.call(ele) }
  count >= n
end

def every?(arr, &block)
  arr.each { |ele| return false if !block.call(ele) }
  true
end

def at_most?(arr, n, &block)
  count = 0
  arr.each { |ele| count += 1 if block.call(ele) }
  count <= n
end

def first_index(arr, &block)
  (0...arr.length).each { |idx| return idx if block.call(arr[idx]) }
  nil
end

# phase_2
def xnor_select(arr, prc_1, prc_2)
  selected = []
  selected
    .concat(arr.select { |ele| prc_1.call(ele) && prc_2.call(ele) })
    .concat(arr.select { |ele| !prc_1.call(ele) && !prc_2.call(ele) })
end

def filter_out!(arr, &block)
  filtered = false
  while !filtered
    filtered = true

    arr.each.with_index do |ele, idx|
      if block.call(ele)
        arr.delete_at(idx)
        filtered = false
      end
    end
  end

  arr
end

def multi_map(arr, n = 1, &block)
  mapped = arr.clone
  n.times { mapped.map! { |ele|block.call(ele) } }
  mapped
end

def proctition(arr, &block)
  truthy = []
  falsy = []

  arr.each { |ele| (truthy << ele if block.call(ele)) || falsy << ele }
  
  [*truthy, *falsy]
end

# Phase 3: Perilous
def selected_map!(arr, prc_1, prc_2)
  arr.map! { |ele| (prc_2.call(ele) if prc_1.call(ele) == true) || ele }
  nil
end

def chain_map(val, arr_of_procs)
  arr_of_procs.each { |proc| val = proc.call(val) }
  val
end

def proc_suffix(sent, procs_hash)
  sent
    .split(" ")
    .map do |word|
      suffixes = ""
      procs_hash.each { |proc, suffix| suffixes += suffix if proc.call(word) }
      word += suffixes
    end
    .join(" ")
end

def proctition_platinum(arr, *procs)
  # initialize empty array on every index of proc; start count from 1
  proc_hash = 
    Hash.new
    (1..procs.length).each { |proc| proc_hash[proc] = [] }

  arr.each do |ele|
    procs.each_with_index do |proc, idx|
      proc_idx = idx + 1
      if proc.call(ele) == true
        proc_hash[proc_idx] << ele
        break
      end
    end
  end

  proc_hash
end

def procipher(sentence, procs_hash)
  ciphered_sent = [] 

  sentence.split(" ").each do |og_word|
    ciphered_word = og_word.clone  
    
    procs_hash.each do |proc_condition, proc_change|
      if proc_condition.call(og_word) == true
        ciphered_word = proc_change.call(ciphered_word) 
      end
    end

    ciphered_sent << ciphered_word
  end

  ciphered_sent.join(" ")
end