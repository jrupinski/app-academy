require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe 'POST #create' do
    context 'with invalid parameters' do
      it 'validates email and password' do
        post users_url, params: { user: { email: '', password: '' } }

        expect(response).to render_template(:new)
        expect(flash[:errors]).to be_present
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'validates that password has at least 6 characters' do
        user = build(:user, password: 'short')
        post users_url, params: { user: { email: user.email, password: user.password } }

        expect(response).to render_template(:new)
        expect(flash[:errors]).to be_present
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'with valid parameters' do
      it 'creates a user and redirects' do
        user = build(:user)
        post users_url, params: { user: { email: user.email, password: user.password } }

        expect(response).to have_http_status(:created)
      end
    end
  end
end
