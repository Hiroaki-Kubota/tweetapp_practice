# frozen_string_literal: true

# User
class User < ApplicationRecord
  has_secure_password
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy

  attr_accessor :image_file, :remove_image

  before_save :update_image

  def update_image
    if ActiveRecord::Type::Boolean.new.cast(@remove_image)
      self.image = nil
      self.image_content_type = nil
    elsif @image_file
      self.image = @image_file.read
      self.image_content_type = @image_file.content_type
    end
    self
  end
end
