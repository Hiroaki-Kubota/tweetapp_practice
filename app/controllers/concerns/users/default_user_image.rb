# frozen_string_literal: true

DEFAULT_IMAGE_PATH = 'public/user_images/default_user.png'
DEFAULT_IMAGE_TYPE = 'image/png'

require 'singleton'

# for default user image
class DefaultUserImage
  include Singleton

  attr_reader :image
  attr_reader :content_type

  def initialize
    File.open(DEFAULT_IMAGE_PATH, 'r+b') do |file|
      @image = file.read
      @content_type = DEFAULT_IMAGE_TYPE
    end
  end
end
