require 'rails_helper'

RSpec.describe "GoalComments", type: :request do
  let(:user) { create(:user) }
  let(:goal) { create(:goal, user: user) }

  describe 'POST #create' do
    context 'When user is logged in' do
      before(:each) do
        post session_path, params: { user: { email: user.email, password: user.password } }
      end

      scenario 'Creates a comment on Goal Profile' do
        post goal_comments_path, params: { goal_comment: { goal_id: goal.id, body: 'Sample text.' } }

        expect(response).to redirect_to(goals_path)
        expect(goal.goal_comments.last.body).to eq('Sample text.')
      end
    end

    context 'When user is anonymous' do
      it 'redirects to login page' do
        post goal_comments_path, params: { goal_comment: { goal_id: goal.id, body: 'Sample text.' } }
        expect(response).to redirect_to(new_session_path)
      end
    end
  end
end
