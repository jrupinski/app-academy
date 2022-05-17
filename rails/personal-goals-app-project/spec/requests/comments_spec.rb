require 'rails_helper'

RSpec.describe "Comments", type: :request do
  let(:user) { create(:user) }
  let(:different_user) { create(:user) }
  let(:goal) { create(:goal, user: user) }

  describe 'POST #create' do
    context 'When user is logged in' do
      before(:each) do
        post session_path, params: { user: { email: user.email, password: user.password } }
      end

      scenario 'Creates a comment on Goal page' do
        post comments_path, params: { comment: { commentable_id: goal.id, commentable_type: 'Goal', body: 'Sample text.' } }

        expect(response).to redirect_to(users_path)
        expect(goal.comments.last.body).to eq('Sample text.')
      end

      scenario 'Creates a comment on User Profile' do
        post comments_path, params: { comment: { commentable_id: different_user.id, commentable_type: 'User', body: 'Sample text.' } }

        expect(response).to redirect_to(users_path)
        expect(different_user.comments.last.body).to eq('Sample text.')
      end
    end

    context 'When user is anonymous' do
      it 'redirects to login page' do
        post comments_path, params: { comment: { commentable_id: goal.id, commentable_type: 'goal', body: 'Sample text.' } }
        expect(response).to redirect_to(new_session_path)
      end
    end
  end
end
