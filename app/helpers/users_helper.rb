# frozen_string_literal: true

# users helper module
module UsersHelper
  # For user default image
  class UserImage
    attr_accessor :image
    attr_accessor :content_type

    def initialize(image, content_type)
      @image = image.read
      @content_type = content_type
    end
  end

  def self.default_user_image
    File.open('public/user_images/default_user.png', 'r+b') do |file|
      @default_image ||= UserImage.new(file, 'image/png')
    end
  end
end
