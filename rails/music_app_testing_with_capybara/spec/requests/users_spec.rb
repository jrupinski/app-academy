require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe 'GET #new' do
    it 'renders the new template' do
      get new_user_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST #create' do
    context 'with invalid params' do
      it "validates the presence of the user's email and password" do
        post users_path, params: { user: { email: 'test@example.com' } }
        expect(response).to redirect_to(new_user_path)

        post users_path, params: { user: { password: '123456' } }
        expect(response).to redirect_to(new_user_path)
      end

      it 'validates that the password is at least 6 characters long' do
        post users_path, params: { user: { password: '123456' } }
        expect(response).to redirect_to(new_user_path)
      end
    end

    context 'with valid params' do
      it 'redirects user to bands index on success' do
        post users_path, params: { user: { email: 'test@example.com', password: '123456' } }
        expect(response).to redirect_to(bands_path)
      end
    end
  end
end
