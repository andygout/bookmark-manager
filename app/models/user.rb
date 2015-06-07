require 'bcrypt'
require 'rest-client'

class User

  include DataMapper::Resource

  property :id, Serial
  property :email, String, unique: true
  property :password_digest, Text
  property :password_token, Text
  property :password_token_timestamp, Time

  attr_reader :password
  attr_accessor :password_confirmation

  validates_uniqueness_of :email
  validates_confirmation_of :password

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def self.authenticate(email, password)
    user = first(email: email)
    if user && BCrypt::Password.new(user.password_digest) == password
      user
    else
      nil
    end
  end

  def email_token
    api_key = ENV['MAILGUN_API_KEY']
    smtp_login = ENV['MAILGUN_SMTP_LOGIN']
    smtp_login_seg = ENV['MAILGUN_SMTP_LOGIN_SEG']
    email_address = ENV['AG_EMAIL_ADDRESS']
    token_url = "<a href='http://localhost:9292/users/reset_password/#{self.password_token}'>here</a>"
    token_deadline = (self.password_token_timestamp + (60 * 60)).strftime("%H:%M on %d %b %Y")

    RestClient.post "https://api:#{api_key}@api.mailgun.net/v3/#{smtp_login_seg}.mailgun.org/messages",
    from: "Bookmark Manager <#{smtp_login}>",
    to: "<#{email_address}>",
    subject: "Email recovery token",
    html: "You have requested an email recovery token. Please click #{token_url} to reset your password.  It must be used by #{token_deadline}."
  end
end