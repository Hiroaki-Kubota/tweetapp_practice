# frozen_string_literal: true

class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :notice, :warning, :danger
end
