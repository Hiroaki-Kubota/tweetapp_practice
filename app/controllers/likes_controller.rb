# frozen_string_literal: true

# Like!
class LikesController < ApplicationController
  before_action :create_like, only: %i[create]
  before_action :set_like, only: %i[destroy]

  def create
    @like.save
    redirect_to post_path(id: params[:post_id])
  end

  def destroy
    @like&.destroy
    redirect_to post_path(id: params[:post_id])
  end

  private

  def create_like
    @like = Like.new(user_id: @current_user.id, post_id: params[:post_id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_like
    @user = Like.find_by(user_id: @current_user.id, post_id: params[:post_id])
  end
end
