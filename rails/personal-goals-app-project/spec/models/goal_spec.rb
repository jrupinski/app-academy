require 'rails_helper'

RSpec.describe Goal, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_length_of(:title).is_at_least(6) }
    it { should belong_to(:user) }
  end

  describe '#toggle_complete' do
    it 'should toggle uncompleted goal to completed ' do
      goal = build(:goal, completed: false)
      goal.toggle_complete
      expect(goal.completed).to eq(true)
    end

    it 'should toggle completed goal to uncompleted ' do
      goal = build(:goal, completed: true)
      goal.toggle_complete
      expect(goal.completed).to eq(false)
    end
  end

  describe '#toggle_private' do
    it 'should toggle public goal to private ' do
      goal = build(:goal, private: false)
      goal.toggle_private
      expect(goal.private).to eq(true)
    end

    it 'should toggle private goal to public ' do
      goal = build(:goal, private: true)
      goal.toggle_private
      expect(goal.private).to eq(false)
    end
  end
end
