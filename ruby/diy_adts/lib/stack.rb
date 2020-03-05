  class Stack
    def initialize
      @stack = []
    end

    # adds an element to the stack
    def push(el)
      @stack.push(el)
    end

    # removes one element from the stack
    def pop
      @stack.pop
    end

    # returns, but doesn't remove, the top element in the stack
    def peek
      @stack.last
    end

    def inspect()
      @stack
    end
  end