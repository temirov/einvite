module AuthorizationsHelper
  def sign_in(authorization)
    cookies[:session_token] = { value:   authorization.session_token,
                                expires: 2.hours.from_now.utc }
    self.current_user = authorization.user
  end

  def signed_in?
    !current_user.nil?
  end

  def sign_out
    self.current_user = nil
    cookies.delete(:session_token)
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= Authorization.with_valid_session_tokens.find_by_session_token(cookies[:session_token]).try(:user) if cookies[:session_token].present?
  end

  def authorization 
    @authorization ||= Authorization.new
  end
end
