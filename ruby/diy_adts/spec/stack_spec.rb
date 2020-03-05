require "stack"

describe Stack do
  it "creates new Stack instance" do
    expect { Stack.new }.to_not raise_error
    expect(Stack.new.inspect).to eq([])
  end

  let(:object1) { 1 }
  let(:object2) { 2 }
  let(:object3) { 3 }
  
  describe "It follows LIFO principle (last-in-first-out)" do
    stack = Stack.new 

    it "Adds new elements on top of stack" do
      expect { stack.push(object1) }.to_not raise_error
      stack.push(object2)
      expect(stack.inspect.last).to eq(object2)
      stack.push(object3)
      expect(stack.inspect.last).to eq(object3)
    end
  
    it "Removes top element from stack" do
      expect { stack.pop }.to_not raise_error
      expect(stack.pop).to eq(object2)
      expect(stack.inspect).to eq([object1])
    end
  end

  it "Allows peeking top element from the stack, without removing it" do
    stack = Stack.new 

    expect { stack.peek }.to_not raise_error
    expect(stack.peek).to eq(nil)
    stack.push(object3)
    expect(stack.peek).to eq(object3)
    stack.push(object2)
    expect(stack.peek).to eq(object2)
  end
end
