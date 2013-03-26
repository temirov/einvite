ActionMailer::Base.smtp_settings = {
  :address        => "smtpout.secureserver.net",
  :domain         => "www.chirpathon.com",
  :port           => 80,
  :user_name      => "support@chirpathon.com",
  :password       => "1974.Chirpathon",
  :authentication => :plain
}
