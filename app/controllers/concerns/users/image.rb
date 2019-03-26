# frozen_string_literal: true

module Concerns
  module Users
    # User Image
    module Image
      extend ActiveSupport::Concern

      def image
        if @user&.image
          send_data(@user.image, type: @user.image_content_type, disposition: :inline)
        else
          send_data(DefaultUserImage.instance.image, type: DefaultUserImage.instance.content_type, disposition: :inline)
        end
      end
    end
  end
end
