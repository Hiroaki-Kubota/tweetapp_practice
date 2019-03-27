# frozen_string_literal: true

require 'test_helper'

class MessagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @msg_one_two = messages(:one_two)
    @msg_two_one = messages(:two_one)
    @msg_two_barebones = messages(:two_barebones)
    @user_one = users(:one)
    @user_two = users(:two)
  end

  test 'should get index' do
    login_as(@user_one)
    get messages_url
    assert_response :success
  end

  test 'should redirect to login when get index without login' do
    get messages_url
    assert_response :redirect
    assert_redirected_to(controller: :users, action: :login)
  end

  test 'should get new' do
    login_as(@user_one)
    get new_message_url
    assert_response :success
  end

  test 'should redirect to login when get new without login' do
    get new_message_url
    assert_response :redirect
    assert_redirected_to(controller: :users, action: :login)
  end

  test 'should create message' do
    login_as(@user_one)
    assert_difference('Message.count') do
      post messages_url, params: { message: { from_user_id: @user_one.id, to_user_id: @user_two.id, content: __method__.to_s } }
    end

    assert_redirected_to(controller: :users, action: :messages, id: @user_one.id)
  end

  test 'should redirect to login when create message without login' do
    assert_no_difference('Message.count') do
      post messages_url, params: { message: { from_user_id: @user_one.id, to_user_id: @user_two.id, content: __method__.to_s } }
    end
    assert_redirected_to(controller: :users, action: :login)
  end

  test 'should show message own sent' do
    login_as(@user_one)
    get message_url(@msg_one_two)
    assert_response :success
  end

  test 'should show message own recieved' do
    login_as(@user_one)
    get message_url(@msg_two_one)
    assert_response :success
  end

  test 'should not show unrelated message' do
    login_as(@user_one)
    get message_url(@msg_two_barebones)
    assert_response :redirect
  end

  test 'should not show message without login' do
    get message_url(@msg_one_two)
    assert_response :redirect
  end

  test 'should get edit message own sent' do
    login_as(@user_one)
    get edit_message_url(@msg_one_two)
    assert_response :success
  end

  test 'should not get edit message own recieved' do
    login_as(@user_one)
    get edit_message_url(@msg_two_one)
    assert_response :redirect
  end

  test 'should not get edit unrelated message' do
    login_as(@user_one)
    get edit_message_url(@msg_two_barebones)
    assert_response :redirect
  end

  test 'should get edit without login' do
    get edit_message_url(@msg_one_two)
    assert_response :redirect
  end

  test 'should update message own sent' do
    login_as(@user_one)
    target = @msg_one_two
    patch message_url(target), params: { message: { content: __method__.to_s } }
    assert_redirected_to message_url(target)
    assert_equal __method__.to_s, Message.find(target.id).content
  end

  test 'should not update message own recieved' do
    login_as(@user_one)
    target = @msg_two_one
    patch message_url(target), params: { message: { content: __method__.to_s } }
    assert_response :redirect
    assert_equal target.content, Message.find(target.id).content
  end

  test 'should not update unrelated message' do
    login_as(@user_one)
    target = @msg_two_barebones
    patch message_url(target), params: { message: { content: __method__.to_s } }
    assert_response :redirect
    assert_equal target.content, Message.find(target.id).content
  end

  test 'should not update without login' do
    target = @msg_one_two
    patch message_url(target), params: { message: { content: __method__.to_s } }
    assert_response :redirect
    assert_equal target.content, Message.find(target.id).content
  end

  test 'should destroy message own sent' do
    login_as(@user_one)
    assert_difference('Message.count', -1) do
      delete message_url(@msg_one_two)
    end

    assert_redirected_to messages_url
  end

  test 'should not destroy message own recieved' do
    login_as(@user_one)
    assert_no_difference('Message.count', -1) do
      delete message_url(@msg_two_one)
    end

    assert_redirected_to users_url
  end

  test 'should not destroy unrelated message' do
    login_as(@user_one)
    assert_no_difference('Message.count', -1) do
      delete message_url(@msg_two_barebones)
    end

    assert_redirected_to users_url
  end

  test 'should not destroy message without login' do
    assert_no_difference('Message.count', -1) do
      delete message_url(@msg_one_two)
    end

    assert_redirected_to login_url
  end
end
