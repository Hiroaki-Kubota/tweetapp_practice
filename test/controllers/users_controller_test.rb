# frozen_string_literal: true

require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:barebones)
    @other_user = users(:one)
    @new_user = User.new(name: 'new', email: 'new@test.com', password: 'new')
  end

  test 'should get index' do
    login_as(@user)
    get users_url
    assert_response :success
  end

  test 'should redirect to login when get index without login' do
    get users_url
    assert_response :redirect
    assert_redirected_to(controller: :users, action: :login)
  end

  test 'should get new' do
    get new_user_url
    assert_response :success
  end

  test 'should redirect to posts when get new with login' do
    login_as(@user)
    get new_user_url
    assert_redirected_to(controller: :posts, action: :index)
  end

  test 'should create user' do
    assert_difference('User.count') do
      post users_url, params: { user: { name: @new_user.name,
                                        email: @new_user.email,
                                        password: @new_user.password } }
    end

    assert_redirected_to(controller: :posts, action: :index)
  end

  test 'should not create user when logged in' do
    login_as(@user)
    assert_no_difference('User.count') do
      post users_url, params: { user: { name: @new_user.name,
                                        email: @new_user.email,
                                        password: @new_user.password } }
    end

    assert_redirected_to(controller: :posts, action: :index)
  end

  test 'should show own user' do
    login_as(@user)
    get user_url(@user)
    assert_response :success
  end

  test 'should show other user' do
    login_as(@user)
    get user_url(@other_user)
    assert_response :success
  end

  test 'should redirect to login when show user without login' do
    get user_url(@user)
    assert_redirected_to(controller: :users, action: :login)
  end

  test 'should get edit own user' do
    login_as(@user)
    get edit_user_url(@user)
    assert_response :success
  end

  test 'should redirect to posts when get edit other user' do
    login_as(@user)
    get edit_user_url(@other_user)
    assert_redirected_to(controller: :posts, action: :index)
  end

  test 'should redirect to login when get edit without login' do
    get edit_user_url(@user)
    assert_redirected_to(controller: :users, action: :login)
  end

  test 'should update own user' do
    login_as(@user)
    patch user_url(@user), params: { user: { email: 'new@email.com' } }
    assert_redirected_to user_url(@user)
    assert_equal 'new@email.com', User.find_by_id(@user.id)&.email
  end

  test 'should redirect to posts when update other user' do
    login_as(@user)
    patch user_url(@other_user), params: { user: { email: 'new@email.com' } }
    assert_redirected_to(controller: :posts, action: :index)
    assert_not_equal 'new@email.com', User.find_by_id(@other_user.id)&.email
  end

  test 'should redirect to login when update without login' do
    patch user_url(@user), params: { user: { email: 'new@email.com' } }
    assert_redirected_to(controller: :users, action: :login)
    assert_not_equal 'new@email.com', User.find_by_id(@user.id)&.email
  end

  test 'should destroy own user' do
    login_as(@user)
    assert_difference('User.count', -1) do
      delete user_url(@user)
    end

    assert_redirected_to users_url
  end

  test 'should redirect to posts when destroy other user' do
    login_as(@user)
    assert_no_difference('User.count') do
      delete user_url(@other_user)
    end
    assert_redirected_to(controller: :posts, action: :index)
  end

  test 'should redirect to login when destroy without login' do
    assert_no_difference('User.count') do
      delete user_url(@user)
    end
    assert_redirected_to(controller: :users, action: :login)
  end
end
