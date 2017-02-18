require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  test "should create categories" do
    assert_difference('Category.count', 5) do
      User.create email: "test@test.fr", 
        password: "20462046",
        password_confirmation: "20462046",
        firstname: "Test", 
        lastname: "Test"
    end
  end
end
