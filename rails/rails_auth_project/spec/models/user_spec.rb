require 'rails_helper'

describe User do
  describe 'Create a new User' do
    it 'has working validations' do
      empty_user = User.new
      password_too_short_user = User.new(username: 'user', password: 'test')

      expect(empty_user).to_not be_valid
      expect(password_too_short_user).to_not be_valid
    end

    it 'creates a User when passed valid parameters' do
      username = 'user'
      password = 'testing'
      user = User.new(username: username, password: password)

      expect { user.save }.to_not raise_error
      expect(User.count).to eq(1)
      expect(User.first.is_password?(password)).to be true
    end
  end
end
