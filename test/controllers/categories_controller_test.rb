require 'test_helper'


class CategoriesControllerTest < ActionDispatch::IntegrationTest

  setup do
    @category = categories(:one)
  end

  test "should get new" do
    login(users(:me))
    get new_category_url
    assert_response :success
  end

  test "should redirect on get new" do
    get new_category_url
    assert_response 302
  end

  test "should create category" do
    login(users(:me))
    assert_difference('Category.count') do
      post categories_url, params: { category: { name: "New category" } }
    end
  end

  test "should get edits" do
    setup_restaurant_host
    login(users(:me))
    get categories_edit_path
    assert_response :success
  end

  test "should redirect get edits on restaurant page" do
    get categories_edit_path
    assert_response 302
  end

  test "should not create category" do
    assert_no_difference('Category.count') do
      post categories_url, params: { category: { name: "New category" } }
    end
  end

  test "should redirect on get edit" do
    get edit_category_path(@category)
    assert_response 302
  end

  test "should get edit" do
    login(users(:me))
    get edit_category_url(@category)
    assert_response :success
  end

  test "should update category" do
    patch category_url(@category), params: { category: { name: @category.name } }
    assert_redirected_to root_url
  end

  test "should redirect on update category" do
    patch category_url(@category), params: { category: { name: @category.name } }
    assert_redirected_to root_url
  end

  test "should not destroy category" do
    assert_no_difference('Category.count') do
      delete category_url(@category)
    end

    assert_redirected_to root_url
  end

  test "should destroy category" do
    login(users(:me))
    assert_difference('Category.count', -1) do
      delete category_url(@category)
    end
  end
end
