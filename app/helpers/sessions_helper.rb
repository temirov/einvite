module SessionsHelper
  def sign_in(user)
    # cookies.permanent[:remember_token] = user.remember_token
    # debugger
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
    @authorization ||= Authorization.find_by_session_token(cookies[:session_token])
    unless @authorization.nil?
      @current_user ||= User.find_by_id(@authorization.user_id)
    end
    @current_user
  end
end
