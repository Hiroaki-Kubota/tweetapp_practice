# frozen_string_literal: true

class Like < ApplicationRecord
  validates :user_id, presence: true
  validates :post_id, presence: true
  belongs_to :user
  belongs_to :post
  validates :user_id, uniqueness: { scope: :post_id }
end
