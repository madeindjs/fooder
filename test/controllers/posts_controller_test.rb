require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:me)
    @post = posts(:one)
    @restaurant = restaurants(:one)
    setup_restaurant_host
  end

  test "should get index" do
    get posts_url
    assert_response :success
  end

  test "should get new" do
    login(@user)
    get new_post_url
    assert_response :success
  end

  test "should redirect get new" do
    get new_post_url
    assert_response 302
  end

  test "should not create post" do
    assert_no_difference('Post.count') do
      post posts_url, params: { post: { content: @post.content, tags: @post.tags, title: @post.title } }
    end
  end

  test "should create post" do
    login(@user)
    assert_difference('Post.count') do
      post posts_url, params: { post: { content: @post.content, tags: @post.tags, title: @post.title } }
    end

    assert_redirected_to post_url(Post.last)
  end

  test "should show post" do
    get post_url(@post)
    assert_response :success
  end

  test "should redirect on get edit" do
    get edit_post_url(@post)
    assert_response 302
  end

  test "should get edit" do
    login(@user)
    get edit_post_url(@post)
    assert_response :success
  end

  test "should recirect update post" do
    patch post_url(@post), params: { post: { content: @post.content, tags: @post.tags, title: @post.title } }
    assert_redirected_to root_url
  end

  test "should update post" do
    login(@user)
    patch post_url(@post), params: { post: { content: @post.content, tags: @post.tags, title: @post.title } }
    assert_redirected_to post_url(@post)
  end

  test "should redirect on destroy post" do
    assert_no_difference('Post.count') do
      delete post_url(@post)
    end

    assert_redirected_to root_url
  end

  test "should destroy post" do
    login(@user)
    assert_difference('Post.count', -1) do
      delete post_url(@post)
    end

    assert_redirected_to posts_url
  end
end
