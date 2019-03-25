# frozen_string_literal: true

require 'test_helper'

# Like Model Test
class LikeTest < ActiveSupport::TestCase
  fixtures :users, :posts

  test 'should save valid like' do
    like = valid_like
    assert like.save, 'Cannot saved the valid like'
  end

  test 'should not save like without user_id' do
    like = valid_like
    like.user_id = nil
    assert_not like.save, 'Saved the like without user_id'
  end

  test 'should not save like with non-existent user_id' do
    like = valid_like
    like.user_id = -1
    assert_not like.save, 'Saved the like with non-existent user_id'
  end

  test 'should not save like without post_id' do
    like = valid_like
    like.post_id = nil
    assert_not like.save, 'Saved the like without post_id'
  end

  test 'should not save like with non-existent post_id' do
    like = valid_like
    like.post_id = -1
    assert_not like.save, 'Saved the like with non-existent post_id'
  end

  private

  def valid_like
    like = Like.new
    like.user_id = users(:barebones).id
    like.post_id = posts(:barebones).id
    like
  end
end
