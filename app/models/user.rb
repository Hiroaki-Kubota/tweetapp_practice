# frozen_string_literal: true

# User
class User < ApplicationRecord
  has_secure_password
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :from_messages, class_name: 'Message', foreign_key: 'from_user_id', dependent: :destroy
  has_many :to_messages, class_name: 'Message', foreign_key: 'to_user_id', dependent: :destroy

  # Scopes
  scope :order_by_name, -> { order(name: :asc) }

  # Validations
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  before_save :update_image

  attr_accessor :image_file, :remove_image

  # Update image on before save
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

  # Send message to other user
  def send_message(to_user, content)
    from_messages.create!(to_user_id: to_user.id, content: content)
  end

  def self.select_list
    order_by_name.pluck(:name, :id)
  end
end
