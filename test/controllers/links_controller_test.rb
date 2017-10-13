require 'test_helper'

class LinksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @link = links(:one)
    setup_restaurant_host
  end

  test "should redirect on get new" do
    get new_link_url
    assert_response :forbidden
  end

  test "should get new" do
    login(users(:me))
    get new_link_url
    assert_response :success
  end

  test "should redirect on create link" do
    assert_no_difference('Link.count') do
      post links_url, params: { link: { name: @link.name, url: @link.url } }
    end
  end

  test "should create link" do
    login(users(:me))
    assert_difference('Link.count') do
      post links_url, params: { link: { name: @link.name, url: @link.url } }
    end
  end

  test "should redirect on get edit" do
    get edit_link_url(@link)
    assert_response :forbidden
  end


  test "should get edit" do
    login(users(:me))
    get edit_link_url(@link)
    assert_response :success
  end

  test "should redirect on update link" do
    patch link_url(@link), params: { link: { name: @link.name, url: @link.url } }
    assert_response :forbidden
  end

  test "should update link" do
    login(users(:me))
    patch link_url(@link), params: { link: { name: @link.name, url: @link.url } }
    assert_response :success
  end

  test "should redirect on destroy link" do
    assert_no_difference('Link.count') do
      delete link_url(@link)
    end
    assert_response :forbidden
  end

  test "should destroy link" do
    login(users(:me))
    assert_difference('Link.count', -1) do
      delete link_url(@link)
    end
    assert_response :success
  end
end
