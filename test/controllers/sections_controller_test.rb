require 'test_helper'

class SectionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @section = sections(:one)
    setup_restaurant_host
  end

  test "should get new" do
    login(users(:me))
    get new_section_url
    assert_response :success
  end

  test "should redirect on get new" do
    get new_section_url
    assert_response :forbidden
  end

  test "should create section" do
    login(users(:me))
    assert_difference('Section.count') do
      post sections_url, params: { section: { content: @section.content, restaurant_id: @section.restaurant_id, title: @section.title, user_id: @section.user_id } }
    end
    assert_response :success
  end

  test "should not create section" do
    assert_no_difference('Section.count') do
      post sections_url, params: { section: { content: @section.content, restaurant_id: @section.restaurant_id, title: @section.title, user_id: @section.user_id } }
    end
  end

  test "should redirect on get edit" do
    get edit_section_url(@section)
    assert_response :forbidden
  end

  test "should get edit" do
    login(users(:me))
    get edit_section_url(@section)
    assert_response :success
  end

  test "should not update section" do
    patch section_url(@section), params: { section: { content: @section.content, restaurant_id: @section.restaurant_id, title: @section.title, user_id: @section.user_id } }
    assert_response :forbidden
  end

  test "should update section" do
    login(users(:me))
    patch section_url(@section), params: { section: { content: @section.content, restaurant_id: @section.restaurant_id, title: @section.title, user_id: @section.user_id } }
    assert_response :success
  end

  test "should not destroy section" do
    assert_no_difference('Section.count') do
      delete section_url(@section)
    end
    assert_response :forbidden
  end

  test "should destroy section" do
    login(users(:me))
    assert_difference('Section.count', -1) do
      delete section_url(@section)
    end
    assert_response :success
  end
end
