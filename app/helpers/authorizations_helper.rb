module AuthorizationsHelper
  def sign_in(user)
    cookies[:session_token] = { value:   user.authorization.session_token,
                                expires: 2.hour.from_now.utc }
    self.current_user = user
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
#    debugger
#    @authorization ||= Authorization.find_by_session_token(cookies[:session_token]) unless cookies[:session_token].nil?
#    @current_user ||= @authorization.user unless @authorization.nil?
    @current_user ||= Authorization.find_by_session_token(cookies[:session_token]).try(:user) unless cookies[:session_token].nil?
  end
end
