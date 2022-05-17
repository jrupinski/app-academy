require 'rails_helper'

RSpec.describe "UserComments", type: :request do
#   let(:user) { create(:user) }
#   let(:different_user) { create(:user) }

#   describe 'POST #create' do
#     context 'When user is logged in' do
#       before(:each) do
#         post session_path, params: { user: { email: user.email, password: user.password } }
#       end

#       scenario 'Creates a comment on User Profile' do
#         post user_comments_path, params: { comment: { user_id: different_user.id, body: 'Sample text.' } }

#         expect(response).to redirect_to(users_path)
#         expect(different_user.user_comments.last.body).to eq('Sample text.')
#       end
#     end

#     context 'When user is anonymous' do
#       it 'redirects to login page' do
#         post user_comments_path, params: { comment: { user_id: different_user.id, body: 'Sample text.' } }
#         expect(response).to redirect_to(new_session_path)
#       end
#     end
#   end
end
