# frozen_string_literal: true

require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:barebones)
    @post = posts(:barebones)
    @new_post = Post.new(content: 'New post')
    @other_user = users(:one)
    @other_post = posts(:one)
  end

  test 'should get index' do
    login_as(@user)
    get posts_url
    assert_response :success
  end

  test 'should redirect to login when get index without login' do
    get posts_url
    assert_response :redirect
    assert_redirected_to(controller: :users, action: :login)
  end

  test 'should get new' do
    login_as(@user)
    get new_post_url
    assert_response :success
  end

  test 'should redirect to login when get new without login' do
    get new_post_url
    assert_response :redirect
    assert_redirected_to(controller: :users, action: :login)
  end

  test 'should create post' do
    login_as(@user)
    assert_difference('Post.count') do
      post posts_url, params: { post: { content: @new_post.content } }
    end

    assert_redirected_to(controller: :posts, action: :index)
  end

  test 'should redirect to login when create post without login' do
    assert_no_difference('Post.count') do
      post posts_url, params: { post: { content: @new_post.content } }
    end
    assert_redirected_to(controller: :users, action: :login)
  end

  test 'should show own post' do
    login_as(@user)
    get post_url(@post)
    assert_response :success
  end

  test 'should show other post' do
    login_as(@user)
    get post_url(@other_post)
    assert_response :success
  end

  test 'should redirect to login when show post without login' do
    get post_url(@post)
    assert_redirected_to(controller: :users, action: :login)
  end

  test 'should get edit own post' do
    login_as(@user)
    get edit_post_url(@post)
    assert_response :success
  end

  test 'should redirect to posts when get edit other post' do
    login_as(@user)
    get edit_post_url(@other_post)
    assert_redirected_to(controller: :posts, action: :index)
  end

  test 'should redirect to login when get edit without login' do
    get edit_post_url(@post)
    assert_redirected_to(controller: :users, action: :login)
  end

  test 'should update own post' do
    login_as(@user)
    patch post_url(@post), params: { post: { content: 'updated' } }
    assert_redirected_to(controller: :posts, action: :index)
    assert_equal 'updated', Post.find_by_id(@post.id)&.content
  end

  test 'should redirect to posts when update other user' do
    login_as(@user)
    patch post_url(@other_post), params: { post: { content: 'updated' } }
    assert_redirected_to(controller: :posts, action: :index)
    assert_not_equal 'updated', Post.find_by_id(@other_post.id)&.content
  end

  test 'should redirect to login when update without login' do
    patch post_url(@post), params: { post: { content: 'updated' } }
    assert_redirected_to(controller: :users, action: :login)
    assert_not_equal 'updated', Post.find_by_id(@other_post.id)&.content
  end

  test 'should destroy own post' do
    login_as(@user)
    assert_difference('Post.count', -1) do
      delete post_url(@post)
    end

    assert_redirected_to posts_url
  end

  test 'should redirect to posts when destroy other post' do
    login_as(@user)
    assert_no_difference('Post.count') do
      delete post_url(@other_post)
    end
    assert_redirected_to(controller: :posts, action: :index)
  end

  test 'should redirect to login when destroy without login' do
    assert_no_difference('Post.count') do
      delete post_url(@post)
    end
    assert_redirected_to(controller: :users, action: :login)
  end
end
