# frozen_string_literal: true

require 'test_helper'

# Post Model Test
class PostTest < ActiveSupport::TestCase
  fixtures :posts, :users

  test 'should save valid post' do
    post = valid_post
    assert post.save, 'Cannot save the valid post'
  end

  test 'should not save post without user id' do
    post = valid_post
    post.user_id = nil
    assert_not post.save, 'Saved the post without user id'
  end

  test 'should not save post with non-existent user id' do
    post = valid_post
    post.user_id = -1
    assert_not post.save, 'Saved the post with non-existent user id'
  end

  test 'should not save post without content' do
    post = valid_post
    post.content = nil
    assert_not post.save, 'Saved the post without a content'
  end

  test 'should save post with content length over 140' do
    post = valid_post
    post.content = 'A' * 140
    assert post.save, 'Cannot saved the post with content length 140'
  end

  test 'should not save post with content length over 140' do
    post = valid_post
    post.content = 'A' * 141
    assert_not post.save, 'Saved the post with content length over 140'
  end

  private

  def valid_post
    post = posts(:barebones)
    post.user_id = users(:barebones).id
    post
  end
end
