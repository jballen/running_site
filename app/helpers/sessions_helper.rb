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
    self.current_user = nil
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    remember_token = User.encrypt(cookies[:remember_token])
    # The ||= operator only performs the lookup if current_user is undefined
    @current_user ||= User.find_by(remember_token: remember_token)
  end

  def signed_in?
    !current_user.nil?
  end
end
