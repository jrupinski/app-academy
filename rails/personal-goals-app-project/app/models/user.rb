class User < ApplicationRecord
  validates :email, :password_digest, :session_token, presence: true
  validates :email, :password_digest, :session_token, uniqueness: true

  validates :password, length: { minimum: 6 }, allow_nil: true

  before_validation :ensure_session_token
  attr_reader :password

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    hashed_password = BCrypt::Password.new(self.password_digest)
    hashed_password.is_password?(password)
  end

  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save!
  end

  def self.find_by_credentials(email:, password:)
    user = User.find_by(email: email)
    user&.is_password?(password) ? user : nil
  end

  def self.generate_session_token
    SecureRandom.urlsafe_base64
  end

  private

  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end
end