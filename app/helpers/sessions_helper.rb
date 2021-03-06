module SessionsHelper
  def sign_in(user)
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.encrypt(remember_token))
    self.current_user = user
  end

  def sign_out
    # Create a new remember_token to invalidate the old one
    current_user.update_attribute(:remember_token, 
                                  User.encrypt(User.new_remember_token))
    # Delete the old remember_token from cookies
    cookies.delete(:remember_token)
    session[:user_id] = nil
    self.current_user = nil
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    if !cookies[:remember_token].nil?
      remember_token = User.encrypt(cookies[:remember_token])
      # The ||= operator only performs the lookup if current_user is undefined
      @current_user ||= User.find_by(remember_token: remember_token)
    elsif !session[:user_id].nil?
       @current_user ||= User.find(session[:user_id]) 
    end
  end

  def current_user?(user)
    user == current_user
  end

  def signed_in?
    !current_user.nil?
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end
  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Please sign in."
    end
  end
  def store_location
    session[:return_to] = request.url if request.get?
  end
end
