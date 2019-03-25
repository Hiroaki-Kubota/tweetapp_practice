# frozen_string_literal: true

require 'test_helper'

class LikesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:barebones)
    @post = posts(:barebones)
    @user_liked = users(:one)
    @post_liked = posts(:one)
  end

  test 'should create like' do
    login_as(@user)
    assert_difference('Like.count') do
      post File.join('/likes', @post.id.to_s)
    end

    assert_redirected_to(@post)
  end

  test 'should not create like when not logged in' do
    assert_no_difference('Like.count') do
      post File.join('/likes', @post.id.to_s)
    end

    assert_redirected_to(@post)
  end

  test 'should not create like when already liked' do
    login_as(@user_liked)
    assert_no_difference('Like.count') do
      post File.join('/likes', @post_liked.id.to_s)
    end

    assert_redirected_to(@post_liked)
  end

  test 'should destroy like' do
    login_as(@user_liked)
    assert_difference('Like.count', -1) do
      delete File.join('/likes', @post_liked.id.to_s)
    end

    assert_redirected_to(@post_liked)
  end

  test 'should not destroy like when not logged in' do
    assert_no_difference('Like.count') do
      delete File.join('/likes', @post_liked.id.to_s)
    end

    assert_redirected_to(@post_liked)
  end

  test 'should not destroy like when not liked' do
    login_as(@user)
    assert_no_difference('Like.count') do
      delete File.join('/likes', @post.id.to_s)
    end

    assert_redirected_to(@post)
  end
end
