require 'rails_helper'

RSpec.describe "Goals", type: :request do
  # Allow expectations on Nil (and remove warning messages about it)
  before(:each) do
    allow_message_expectations_on_nil
  end

  let(:user) { create(:user) }
  let(:different_user) { create(:user) }

  describe 'GET #index' do
    context 'When user is logged in' do
      before(:each) do
        post session_path, params: { user: { email: user.email, password: user.password } }
      end

      it 'returns user goals' do
        create(:goal, user: user)
        create(:goal, user: different_user)

        post session_path, params: { user: { email: user.email, password: user.password } }
        get goals_path

        expect(response).to be_successful
        # debugger
        expect(controller.instance_variable_get(:@goals)).to eq(user.goals)
        expect(controller.instance_variable_get(:@goals)).to_not eq(different_user.goals)
      end
    end

    context 'When user is anonymous' do
      it 'redirects to login page' do
        get goals_path
        expect(response).to redirect_to(new_session_path)
      end
    end
  end

  describe 'POST #create' do
    context 'When user is logged in' do
      before(:each) do
        post session_path, params: { user: { email: user.email, password: user.password } }
      end

      context 'with invalid parameters' do
        it 'redirects to #new' do
          post goals_path, params: { goal: {title: '' } }
          expect(flash[:errors]).to be_present
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end

      context 'with valid parameters' do
        it 'redirects to goal show page' do
          goal = build(:goal)
          goal_params = { title: goal.title, description: goal.description, private: goal.private, user_id: user.id }

          post goals_path, params: { goal: goal_params }
          expect(response).to redirect_to goal_path(Goal.last)
        end
      end
    end

    context 'When user is anonymous' do
      it 'redirects to login page' do
        post goals_path, params: { goal: { title: ''} }
        expect(response).to redirect_to(new_session_path)
      end
    end
  end
end
