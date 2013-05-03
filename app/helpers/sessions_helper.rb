module SessionsHelper

  def sign_in(user)
    @page_id = "session_signin"
    #cookies.permanent.signed[:remember_token] = [user.id, user.salt]
    cookies.signed[:remember_token] = {value: [user.id, user.salt], expires: 12.hours.from_now.utc}
    current_user = user
  end
  
  def preferred_group?
    !cookies[:preferred_group].nil?
  end

  def current_user=(user)
    @current_user = user
  end
  
  def sign_out
    @page_id = "session_signout"
    cookies.delete(:remember_token)
    current_user = nil
  end
  
  def signed_in?
    !current_user.nil?
  end
  
  def current_user
    @current_user ||= user_from_remember_token
  end

  def deny_access
    redirect_to signin_path, :notice => "Bitte f&uuml;r den Zugriff auf diese Seite erst anmelden."
  end
  
  private

  def user_from_remember_token
    User.authenticate_with_salt(*remember_token)
  end

  def remember_token
    cookies.signed[:remember_token] || [nil, nil]
  end
end