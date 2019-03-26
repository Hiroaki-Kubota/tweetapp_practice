# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'base64'

module ActiveSupport
  class TestCase
    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
    def self.image_data(file_name)
      Base64.encode64(IO.read("test/fixtures/files/images/#{file_name}")).gsub(/^/, '    ')
    end
  end
end
module SignInHelper
  module IntegrationTest
    def login_as(user)
      post login_url(email: user.email, password: user.name)
    end
  end

  module SystemTestCase
    def login_as(user)
      visit login_url
      fill_in 'email', with: user.email
      fill_in 'password', with: user.name
      find(:xpath, "//input[contains(@name, 'commit')]").click
    end
  end
end

module ActionDispatch
  class IntegrationTest
    include SignInHelper::IntegrationTest
  end

  class SystemTestCase
    include SignInHelper::SystemTestCase
  end
end

module UserImageHelper
  def compare_user_image(expected_image_name, actual_user)
    expected_image = Magick::Image.read("test/fixtures/files/images/#{expected_image_name}").first
    actual_image = Magick::Image.from_blob(User.find_by(email: actual_user.email).image).shift
    diff = expected_image.difference(actual_image)
    diff.sum
  end
end
