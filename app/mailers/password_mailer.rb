class PasswordMailer < ActionMailer::Base
  default from: "eInvite@temirov.net"

  def password_email(authorization)
    @authorization = authorization
    @url = "#{request.protocol}#{request.fullpath}"
    # @url  = 'http://localhost:3000/'
    mail(to: @authorization.user.email, subject: 'Chirpathon registration: your password')
  end
end
