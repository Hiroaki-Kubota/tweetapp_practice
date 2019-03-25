# frozen_string_literal: true

require 'test_helper'

# User Model Test
class UserTest < ActiveSupport::TestCase
  fixtures :users

  test 'should save valid user' do
    user = valid_user
    assert user.save, 'Cannot save valid user'
  end

  test 'should not save user without name' do
    user = valid_user
    user.name = nil
    assert_not user.save, 'Save the user without a name'
  end

  test 'should not save user without email' do
    user = valid_user
    user.email = nil
    assert_not user.save, 'Save the user without a email'
  end

  test 'should not save user without password' do
    user = valid_user
    user.password = nil
    assert_not user.save, 'Save the user without a password'
  end

  private

  def valid_user
    user = users(:barebones)
    user.password = 'barebones'
    user
  end
end
