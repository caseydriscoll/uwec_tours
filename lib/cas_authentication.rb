module CasAuthentication
  
  
  # Inclusion hook to make #current_user and #logged_in?
  # available as ActionView helper methods.
  def self.included(base)
    base.send :helper_method, :current_user, :logged_in?
  end
  
  def logged_in?
    !!current_user
  end
  
  def login_required
    login_from_cas
  end
      
  def login_from_cas
     unless session[:cas_user] || session[:user_id]
      
       CASClient::Frameworks::Rails::Filter.filter(self)
       return unless session[:cas_user]
     end  
     # If the user has already logged in through CAS or the user logged in via a different method
     # look them up in our system - based on restful_auth's login_from_session
     ## This must be in an if block so that it can redirect to CAS on the first pass and not try to find a user first
    self.current_user = locate_user
    access_denied unless self.current_user
    self.current_user
  end

  def locate_user
    if session[:user_id]
      # If the user has already logged in via a method other than cas
      user = find_user_by_id(session[:user_id])
    elsif session[:cas_user]                                                             
      # This is for the first time the user logs in with CAS, every other time :cas_user will be nil
      # It must be in an elsif for logged_in? to not try to find a user if no one is logged in.
      user = find_user_by_username(session[:cas_user])
    end
    user
  end
  
  # Override this with how you would like to find users who log in without CAS
  def find_user_by_id(id)
    User.find_by_id(id)
  end
  
  # Override this with how you would like to find users by their username from CAS
  def find_user_by_username(username)
    user = User.find_or_initialize_by_username(session[:cas_user])
    user.save!
    user
  end

  # feel free to override this method in your own controller
  # to handle situations where they get past CAS but
  # don't get past your own internal database.
  def access_denied
    render("Not allowed")
  end

  # Accesses the current user from the session. 
  # Future calls avoid the database because nil is not equal to false.
  def current_user
   @current_user ||= (locate_user) unless @current_user == false
  end

  # Store the given user id in the session.
  def current_user=(new_user)
    @current_user = new_user || false
  end
  
  # Store the URI of the current request in the session.
  #
  # We can return to this location by calling #redirect_back_or_default.
  def store_location
    session[:return_to] = request.request_uri
  end

  # Redirect to the URI stored by the most recent store_location call or
  # to the passed default.
  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end
  
end
