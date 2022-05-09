require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { create(:user) }

  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }

    it { should validate_length_of(:password).is_at_least(6) }
    it { should validate_presence_of(:password_digest) }

    it { should validate_uniqueness_of(:session_token) }
  end

  it 'creates a password_digest if given a password' do
    new_user = build(:user)
    expect(new_user.password_digest).to_not be_nil
  end

  it 'creates a session token before validation' do
    new_user = build(:user)
    expect(new_user.session_token).to be_nil
    new_user.valid?
    expect(new_user.session_token).to_not be_nil
  end

  describe '#reset_session_token!' do
    it 'remove old session_token and generate a new one' do
      user.valid?
      old_session_token = user.session_token
      user.reset_session_token!

      expect(user.session_token).to_not eq(old_session_token)
    end
  end

  describe '#is_password' do
    it 'verifies is provided password is valid' do
      expect(user.is_password?(user.password)).to be true
    end

    it 'verifies is provided password is not valid' do
      expect(user.is_password?('wrong_password')).to be false
    end
  end

  describe '::find_by_credentials' do
    it 'returns a User if credentials are valid' do
      another_user = create(:user)

      expect(User.find_by_credentials(email: user.email, password: user.password)).to eq(user)
      expect(User.find_by_credentials(email: another_user.email, password: another_user.password)).to eq(another_user)
    end

    it 'returns nil if credentials are not valid' do
      expect(User.find_by_credentials(email: user.email, password: 'wrong_password')).to be_nil
      expect(User.find_by_credentials(email: 'wrong_email@example.com', password: user.password)).to be_nil
    end
  end
end
