class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true
  validates :session_token, presence: true
  validates :password_digest, presence: { message: "Password can't be blank" }
  validates :password, length: { minimum: 6 }, allow_nil: true

  attr_reader :password

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end
end
