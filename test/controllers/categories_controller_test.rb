require 'test_helper'
require "authlogic/test_case"

class CategoriesControllerTest < ActionDispatch::IntegrationTest

  setup :activate_authlogic

  setup do
    @category = categories(:one)
  end

  test "should get new" do
    UserSession.create(users(:me))
    get new_category_url
    assert_response :success
  end

  test "should redirect on get new" do
    get new_category_url
    assert_response 302
  end

  test "should create category" do
    UserSession.create(@category.user)
    assert_difference('Category.count') do
      post categories_url, params: { category: { name: "New category" } }
    end

    assert_redirected_to category_url(Category.last)
  end

  test "should not create category" do
    assert_no_difference('Category.count') do
      post categories_url, params: { category: { name: "New category" } }
    end

    assert_redirected_to category_url(Category.last)
  end

  test "should redirect on get edit" do
    get edit_category_url(@category)
    assert_response 302
  end

  test "should get edit" do
    UserSession.create(@category.user)
    get edit_category_url(@category)
    assert_response :success
  end

  test "should update category" do
    patch category_url(@category), params: { category: { name: @category.name } }
    assert_redirected_to category_url(@category)
  end

  test "should redirect on update category" do
    patch category_url(@category), params: { category: { name: @category.name } }
    assert_redirected_to home_path
  end

  test "should be redirected on destroy category" do
    assert_no_difference('Category.count') do
      delete category_url(@category)
    end

    assert_redirected_to categories_url
  end

  test "should not destroy category" do
    assert_no_difference('Category.count') do
      delete category_url(@category)
    end

    assert_redirected_to categories_url
  end

  test "should destroy category" do
    UserSession.create(users(:me))
    assert_difference('Category.count', -1) do
      delete category_url(@category)
    end

    assert_redirected_to categories_url
  end
end
