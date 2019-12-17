#
# Todo Board, which contains a single list of items
#
class Todo_Board
  def initialize(label)
    @list = List.new(label)
  end
end