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
end
