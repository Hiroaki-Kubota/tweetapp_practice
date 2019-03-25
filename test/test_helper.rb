# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

module ActiveSupport
  class TestCase
    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
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
