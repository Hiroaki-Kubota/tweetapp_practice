# frozen_string_literal: true

class Post < ApplicationRecord
  validates :content,
            presence: true,
            length: { maximum: 140 }
end
