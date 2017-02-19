require 'test_helper'

class SectionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @section = sections(:one)
  end

  test "should get new" do
    login(users(:me))
    get new_restaurant_section_url(restaurant_id: 1)
    assert_response :success
  end

  test "should redirect on get new" do
    get new_restaurant_section_url(restaurant_id: 1)
    assert_response 302
  end

  test "should create section" do
    login(users(:me))
    assert_difference('Section.count') do
      post restaurant_sections_url(restaurant_id: 1), params: { section: { content: @section.content, restaurant_id: @section.restaurant_id, title: @section.title, user_id: @section.user_id } }
    end

    assert_redirected_to restaurant_url(Section.last.restaurant_id)
  end

  test "should not create section" do
    assert_no_difference('Section.count') do
      post restaurant_sections_url(restaurant_id: 1), params: { section: { content: @section.content, restaurant_id: @section.restaurant_id, title: @section.title, user_id: @section.user_id } }
    end
  end

  test "should redirect on get edit" do
    get edit_restaurant_section_url(@section, restaurant_id: @section.restaurant_id)
    assert_response 302
  end

  test "should get edit" do
    login(users(:me))
    get edit_restaurant_section_url(@section, restaurant_id: @section.restaurant_id)
    assert_response :success
  end

  test "should not update section" do
    patch restaurant_section_url(@section, restaurant_id: @section.restaurant_id), params: { section: { content: @section.content, restaurant_id: @section.restaurant_id, title: @section.title, user_id: @section.user_id } }
    assert_redirected_to home_url
  end

  test "should update section" do
    login(users(:me))
    patch restaurant_section_url(@section, restaurant_id: @section.restaurant_id), params: { section: { content: @section.content, restaurant_id: @section.restaurant_id, title: @section.title, user_id: @section.user_id } }
    assert_redirected_to restaurant_url(@section.restaurant_id)
  end

  test "should not destroy section" do
    assert_no_difference('Section.count') do
      delete restaurant_section_url(@section, restaurant_id: @section.restaurant_id)
    end
  end

  test "should destroy section" do
    login(users(:me))
    assert_difference('Section.count', -1) do
      delete restaurant_section_url(@section, restaurant_id: @section.restaurant_id)
    end

    assert_redirected_to restaurant_url(@section.restaurant_id)
  end
end
