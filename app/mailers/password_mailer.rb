class PasswordMailer < ActionMailer::Base
  default from: "eInvite@temirov.net"

  def password_email(authorization)
    debugger
    @authorization = authorization
    @url  = 'http://localhost:3000/'
    mail(to: authorization.user.email, subject: 'eInvite Registration: your password')
  end
end
