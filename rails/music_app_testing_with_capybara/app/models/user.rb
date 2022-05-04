class User < ApplicationRecord
  validates :email, :session_token, :password_digest, presence: true
  validates :email, :session_token, uniqueness: true
  validates :password, length: { minimum: 6 }, allow_nil: true

  after_initialize :ensure_session_token

  has_many :notes

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

  # Generate url-safe session token
  #
  # @return [String] session token
  #
  def self.generate_session_token
    SecureRandom.urlsafe_base64
  end

  #
  # Generate and assign new session token for User
  #
  # @return [String] new session token
  #
  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save!
    self.session_token
  end

  private

  #
  # Validate if session token is assigned, if not - create a new one
  #
  # @return [String] session token
  #
  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end
end
