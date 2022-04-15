class User < ActiveRecord::Base
  validates :username, presence: false
  validates :password_digest, presence: { message: "Password can't be blank" }
  # Add allow_nil to make sure existing users are valid when using #valid.
  # This is because @password is initialized but not saved/persisted.
  validates :password, length: { minimum: 6, allow_nil: true }

  attr_reader :password

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    user_password = BCrypt::Password.new(self.password_digest)
    user_password.is_password?(password)
  end

  # attr_reader :password

  # validates :username, :password_digest, :session_token, presence: true
  # validates :password, length: { minimum: 6, allow_nil: true }

  # before_validation :ensure_session_token

  # def self.find_by_credentials(username, password)
  #   user = User.find_by(username: username)

  #   # no user with given username
  #   return nil if user.nil?

  #   # check user's password
  #   user.password_digest.is_password?(password) ? user : nil
  # end

  # def password=(password)
  #   @password = password
  #   self.password_digest = BCrypt::Password.create(password)
  # end

  # def password_digest
  #   BCrypt::Password.new(super)
  # end

  # def ensure_session_token
  #   self.session_token ||= SecureRandom::urlsafe_base64
  # end

  # def reset_session_token!
  #   self.session_token = SecureRandom::urlsafe_base64
  #   self.save!
  # end
end