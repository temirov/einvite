ActionMailer::Base.smtp_settings = {
    :address => "smtp.1and1.com",
    :port => 587,
    :domain => "1and1.com",
    :authentication => :login,
    :user_name => "eInvite@temirov.net",
    :password => "1and1.eInvite"
  }

# ActionMailer::Base.register_interceptor(PasswordByMailIntercepter)