class PasswordByMailIntercepter
  def self.delivering_email(message)
    message.subject = "[#{message.to}] #{message.subject}"
    # message.to = "eifion@asciicasts.com"
  end
end