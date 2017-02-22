require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:me)
    @post = posts(:one)
    @restaurant = restaurants(:one)
  end

  test "should get index" do
    get restaurant_posts_url(@restaurant)
    assert_response :success
  end

  test "should get new" do
    login(@user)
    get new_restaurant_post_url(@restaurant)
    assert_response :success
  end

  test "should redirect get new" do
    get new_restaurant_post_url(@restaurant)
    assert_response 302
  end

  test "should not create post" do
    assert_no_difference('Post.count') do
      post restaurant_posts_url(@restaurant), params: { post: { content: @post.content, tags: @post.tags, title: @post.title } }
    end
  end

  test "should create post" do
    login(@user)
    assert_difference('Post.count') do
      post restaurant_posts_url(@restaurant), params: { post: { content: @post.content, tags: @post.tags, title: @post.title } }
    end

    assert_redirected_to restaurant_post_url(@restaurant, Post.last)
  end

  test "should show post" do
    get restaurant_post_url(@restaurant, @post)
    assert_response :success
  end

  test "should redirect on get edit" do
    get edit_restaurant_post_url(@restaurant, @post)
    assert_response 302
  end

  test "should get edit" do
    login(@user)
    get edit_restaurant_post_url(@restaurant, @post)
    assert_response :success
  end

  test "should recirect update post" do
    patch restaurant_post_url(@restaurant, @post), params: { post: { content: @post.content, tags: @post.tags, title: @post.title } }
    assert_redirected_to restaurant_url(@restaurant)
  end

  test "should update post" do
    login(@user)
    patch restaurant_post_url(@restaurant, @post), params: { post: { content: @post.content, tags: @post.tags, title: @post.title } }
    assert_redirected_to restaurant_post_url(@restaurant, @post)
  end

  test "should redirect on destroy post" do
    assert_no_difference('Post.count') do
      delete restaurant_post_url(@restaurant, @post)
    end

    assert_redirected_to restaurant_url(@restaurant)
  end

  test "should destroy post" do
    login(@user)
    assert_difference('Post.count', -1) do
      delete restaurant_post_url(@restaurant, @post)
    end

    assert_redirected_to restaurant_posts_url(@restaurant)
  end
end
