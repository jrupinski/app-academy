class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true
  validates :session_token, presence: true
  validates :password_digest, presence: { message: "Password can't be blank" }
  validates :password, length: { minimum: 6 }, allow_nil: true

  before_validation :ensure_session_token

  attr_reader :password

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def self.generate_session_token
    SecureRandom.urlsafe_base64(16) # default is already 16 bytes, but documentation says it might change
  end

  def reset_session_token!
    session_token = self.class.generate_session_token
    save!
    session_token
  end

  private

  def ensure_session_token
    # copy-pasted reason for '||=' operator:
    # we must be sure to use the ||= operator instead of = or ||, otherwise
    # we will end up with a new session token every time we create
    # a new instance of the User class. This includes finding it in the DB!
    self.session_token ||= self.class.generate_session_token
  end
end
