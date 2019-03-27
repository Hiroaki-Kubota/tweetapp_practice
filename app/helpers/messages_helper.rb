# frozen_string_literal: true

module MessagesHelper
  def body_class_name(message, user)
    message&.sent_by?(user) ? 'message-body-left' : 'message-body-right'
  end

  def kaiwa_class_name(message, user)
    !message&.sent_by?(user) ? 'kaiwa-text-left' : 'kaiwa-text-right'
  end

  def left_user(message, user)
    !message&.sent_by?(user) ? message&.from_user : message&.to_user
  end

  def right_user(message, user)
    !message&.sent_by?(user) ? message&.to_user : message&.from_user
  end
end
