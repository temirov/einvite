module AuthorizationsHelper
  def sign_in(authorization)
    # debugger
    cookies[:session_token] = { value:   authorization.session_token,
                                expires: 2.hour.from_now.utc }
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
    @current_user ||= Authorization.find_by_session_token(cookies[:session_token]).try(:user) if cookies[:session_token].present?
  end
end
