# frozen_string_literal: true

module Concerns
  module Users
    # User messages
    module Messages
      extend ActiveSupport::Concern

      def messages
        @messages = Message.recent(@current_user, @user)
      end
    end
  end
end
