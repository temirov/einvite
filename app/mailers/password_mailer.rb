class PasswordMailer < ActionMailer::Base
  default from: "eInvite@temirov.net"

  def password_email(authorization)
    @authorization = authorization
    @url  = 'http://localhost:3000/'
    mail(to: @authorization.user.email, subject: 'Chirpathon Registration: your password')
  end
end
