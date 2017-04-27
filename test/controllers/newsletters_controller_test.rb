require 'test_helper'

class NewslettersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @newsletter = newsletters(:one)
  end

  
  test "should create newsletter" do
    assert_difference('Newsletter.count') do
      post newsletters_url, params: { newsletter: { email: 'madeindjs@gmail.com' } }
    end

    assert_redirected_to root_url
  end


  test "should destroy newsletter" do
    assert_difference('Newsletter.count', -1) do
      delete newsletter_url(@newsletter)
    end

    assert_redirected_to root_url
  end
end
