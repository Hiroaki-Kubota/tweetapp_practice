# frozen_string_literal: true

# Message
class Message < ApplicationRecord
  belongs_to :from_user, class_name: 'User'
  belongs_to :to_user, class_name: 'User'

  # Scopes
  default_scope -> { order(created_at: :desc).limit(200) }

  # Validations
  validates :from_user_id, presence: true
  validates :to_user_id, presence: true
  validates :content, presence: true, length: { maximum: 50 }

  # Methods
  class << Message
    def recent(from_user, to_user)
      if from_user == to_user
        where(from_user_id: from_user.id).or(where(to_user_id: from_user.id))
      else
        where(from_user_id: from_user.id, to_user_id: to_user.id).or(where(to_user_id: from_user.id, from_user_id: to_user.id))
      end
    end
  end

  # Get whether the message is related with the user.
  def related?(user)
    [from_user_id, to_user_id].include?(user&.id)
  end

  # Gets whether the message was sent by the user.
  def sent_by?(user)
    from_user_id == user&.id
  end
end
