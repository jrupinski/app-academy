require "queue"

describe Queue do
  it "creates new Queue instance" do
    expect { Queue.new }.to_not raise_error
    expect(Queue.new.inspect).to eq([])
  end

  let(:object1) { 1 }
  let(:object2) { 2 }
  let(:object3) { 3 }
  let(:object4) { 4 }
  let(:object5) { 5 }
  
  describe "It follows FIFO principle (first-in-first-out)" do
    queue = Queue.new 

    it "Adds new elements to the back of queue" do
      expect { queue.enqueue(object1) }.to_not raise_error
      queue.enqueue(object2)
      expect(queue.inspect.last).to eq(object2)
      queue.enqueue(object3)
      expect(queue.inspect.last).to eq(object3)
    end
  
    it "Removes first element from queue" do
      queue.enqueue(object4)
      queue.enqueue(object5)
      expect { queue.dequeue }.to_not raise_error
      expect(queue.dequeue).to eq(object2)
      expect(queue.inspect).to eq([object3, object4, object5])
    end
  end

  it "Allows \"peeking\" - return first element from queue, without removing it" do
    queue = Queue.new 
    queue.enqueue(object1)
    queue.enqueue(object2)

    expect { queue.peek }.to_not raise_error
    expect(queue.peek).to eq(object1)
    queue.enqueue(object3)
    expect(queue.peek).to eq(object1)
    queue.dequeue
    expect(queue.peek).to eq(object2)
  end
end
