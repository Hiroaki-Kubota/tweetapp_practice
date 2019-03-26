# frozen_string_literal: true

# Session
module SessionAction
  extend ActiveSupport::Concern

  def set_current_user
    @current_user = User.find_by(id: session[:user_id])
  end
end
