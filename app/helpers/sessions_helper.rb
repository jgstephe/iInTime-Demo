module SessionsHelper

  def sign_in(user)
    cookies.permanent.signed[:remember_token] = [user.id, user.salt]
    #session[:remember_token] = user.id
    current_user = user
  end
    
  def current_user
    if @current_user
      puts "Got current user: #{@current_user}"
      @current_user
    else
      puts "Getting user from token…"
      @current_user = user_from_remember_token
    end
  end
  
  def signed_in?
    !current_user.nil?
  end
  
  def sign_out
    #session.delete(:remember_token)
    cookies.delete(:remember_token)
    current_user = nil
  end

  def authenticate
    deny_access unless signed_in?
  end

  def deny_access
    store_location
    redirect_to root_path, :notice => "Please sign in to access this page"
  end
  
  def current_user?(user)
    user == current_user
  end
  
  def redirect_back_or_to(default)
    redirect_to(session[:return_to] || default)
    clear_return_to
  end
  
  private
    def current_user=(user)
      @current_user = user
    end
    
    def user_from_remember_token
      #User.find_by_id(remember_token)
      User.authenticate_with_salt(*remember_token)
    end
    
    def remember_token
      #session[:remember_token] || -1
      cookies.signed[:remember_token] || [nil, nil]
    end
    
    def store_location
      session[:return_to] = request.fullpath
    end
    
    def clear_return_to
      session[:return_to]
    end
end
