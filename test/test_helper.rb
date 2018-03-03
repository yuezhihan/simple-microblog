require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def logged_in?
    !session[:user_id].nil?
  end

  def log_in_by_session(user)
    session[:user_id] = user.id
  end

  def log_in(user, password: 'password', remember_me: '1')
    post login_path, params: { session: { email: user.email,
                                          password: password,
                                          remember_me: remember_me } }
  end


  BASE_TITLE = "Weibo App"
  # Add more helper methods to be used by all tests here...
end

