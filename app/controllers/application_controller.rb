# frozen_string_literal: true

# ApplicationController
class ApplicationController < ActionController::Base
  include SessionAction

  add_flash_types :success, :info, :notice, :warning, :danger
  before_action :set_current_user

  def authenticate_user
    return if @current_user

    flash[:notice] = 'ログインが必要です'
    redirect_to(:login)
  end

  def forbid_login_user
    return unless @current_user

    redirect_to(:posts)
  end
end
