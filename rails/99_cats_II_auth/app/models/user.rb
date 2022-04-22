require 'bcrypt'

class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true
  validates :session_token, presence: true, uniqueness: true
  validates :password_digest, presence: { message: "Password can't be blank" }
  validates :password, length: { minimum: 6 }, allow_nil: true

  after_initialize :ensure_session_token

  has_many :cats, dependent: :destroy

  attr_reader :password

  def password=(password)
    @password = password
    hashed_password = BCrypt::Password.create(password)
    self.password_digest = hashed_password
  end

  def is_password?(password)
    hashed_password = BCrypt::Password.new(self.password_digest)
    hashed_password.is_password?(password)
  end

  def self.find_by_credentials(username:, password: )
    user = User.find_by(username: username)
    user if user && user.is_password?(password)
  end

  def self.generate_session_token
    SecureRandom.urlsafe_base64
  end

  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save!
    self.session_token
  end

  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end
end
