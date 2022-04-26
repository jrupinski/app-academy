class User < ApplicationRecord
  validates :email, :session_token, presence: true
  validates :password_digest, presence: { message: 'Password cannot be empty' }
  validates :email, :session_token, uniqueness: true
  validates :password, length: { minimum: 6 }, allow_nil: true

  attr_reader :password

  #
  # Hash a password string and assign it to User
  #
  # @param [String] password password string
  #
  # @return [String] entered password string
  #
  def password=(password)
    @password = password
    return if password.nil?

    self.password_digest = BCrypt::Password.create(password)
  end

  #
  # Checked if password string matches the User password that's hashed
  #
  # @param [String] password password string
  #
  # @return [Boolean] True if password matches, false if it's wrong
  #
  def is_password?(password)
    hashed_password = BCrypt::Password.new(self.password_digest)
    hashed_password.is_password?(password)
  end

  #
  # Find User using his credentials
  #
  # @param [String] email User email address
  # @param [String] password User password
  #
  # @return [User] Instance of User if credentials are valid, or nil otherwise
  #
  def self.find_by_credentials(email:, password:)
    user = User.find_by(email: email)
    return user if user&.is_password?(password)
  end
end
