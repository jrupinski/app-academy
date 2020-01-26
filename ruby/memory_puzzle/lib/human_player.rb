class HumanPlayer
  def guess
    prompt_for_input
  end

  def prompt_for_input
    print  "Enter row and col numbers, separated by a comma:"
    get_input
  end
    
  def get_input
    input = gets.chomp
    # convert string "n, n" to number array [n, n]
    input.split.map(&:to_i)
  end
end