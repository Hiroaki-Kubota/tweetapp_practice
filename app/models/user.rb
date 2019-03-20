# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy

  def image_path
    File.join('public/user_images', ref_image_name)
  end

  def image_source_path
    File.join('/user_images', ref_image_name)
  end

  private

  def ref_image_name
    image_name || 'default_user.png'
  end
end
