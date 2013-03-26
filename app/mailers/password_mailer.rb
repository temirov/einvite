class PasswordMailer < ActionMailer::Base
  default from: "support@chirpathon.com"

  def password_email(authorization)
    @authorization = authorization
    @email = @authorization.user.email
    @password = @authorization.new_password
    @login_url  = edit_authorization_url(@authorization)
    mail(to: @email, subject: 'Chirpathon registration: your password')
  end
end
