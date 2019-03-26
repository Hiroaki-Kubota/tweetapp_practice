# frozen_string_literal: true

require 'test_helper'

# User Model Test
class UserTest < ActiveSupport::TestCase
  setup do
    @user = users(:barebones)
  end

  test 'should save valid user' do
    user = @user
    assert user.save, 'Cannot save valid user'
  end

  test 'should not save user without name' do
    user = @user
    user.name = nil
    assert_not user.save, 'Save the user without a name'
  end

  test 'should not save user without email' do
    user = @user
    user.email = nil
    assert_not user.save, 'Save the user without a email'
  end

  test 'should not save user without password' do
    user = @user
    user.password = nil
    assert_not user.save, 'Save the user without a password'
  end
end
