# frozen_string_literal: true

class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  def ref_image_name
    image_name || 'default_user.png'
  end
end
