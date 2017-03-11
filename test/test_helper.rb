ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all


  def login(user)
    post user_sessions_url, params:{ user_session: { email: user.email, password: '20462046', remember_me: false}}
  end

  def assert_logged_in
    assert session[:user_credentials].present?
  end

  def assert_not_logged_in
    assert session[:user_credentials].blank?
  end

  def setup_restaurant_host
    host! "http://au-lagon-bleu.example.com/"
  end

  # Add more helper methods to be used by all tests here...
end
