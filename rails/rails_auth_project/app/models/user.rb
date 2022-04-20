class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true
  validates :session_token, presence: true
  validates :password_digest, presence: { message: "Password can't be blank" }
  validates :password, length: { minimum: 6 }, allow_nil: true

  before_validation :ensure_session_token

  attr_reader :password

  #
  # Hash password string and assign it to User
  #
  # @param [String] password User password
  #
  # @return [String] Hashed password
  #
  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  #
  # Check if password String matches the password digest when hashed
  #
  # @param [String] password Password string 
  #
  # @return [Boolean] True if password matches
  #
  def is_password?(password)
    hashed_password = BCrypt::Password.new(self.password_digest)
    hashed_password.is_password?(password)
  end

  #
  # Find User by his username and password
  #
  # @param [String] username User's username
  # @param [String] password User's password
  #
  # @return [User] User matching the username and password
  #
  def self.find_by_credentials(username:, password:)
    user = User.find_by(username: username)

    return user if user && user.is_password?(password)
  end

  #
  # Generate a 16-byte session token to assign to user
  #
  # @return [String] Session token
  #
  def self.generate_session_token
    SecureRandom.urlsafe_base64(16) # default is already 16 bytes, but documentation says it might change
  end

  #
  # Removes old session token and generates a new one, assigning it to User
  #
  # @return [String] Session Token
  #
  def reset_session_token!
    session_token = self.class.generate_session_token
    save!
    session_token
  end

  private

  #
  # Returns existing User's session token, or assings a new one if it doesn't exist
  #
  # @return [String] Session Token
  #
  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end
end
