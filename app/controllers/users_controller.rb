# frozen_string_literal: true

# User
class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show; end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit; end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    upload_image
    remove_image
    response_after_update('ユーザー登録が完了しました', :created, :new) { @user.save }
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    upload_image
    remove_image
    response_after_update('ユーザー情報を編集しました', :ok, :edit) { @user.update(user_params) }
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:name, :email, :image_name)
  end

  def image_path(image_name)
    File.join('public/user_images', image_name || '')
  end

  def upload_image
    return unless params[:user][:image]

    @user.image_name = "#{@user.id}.jpg"
    image = params[:user][:image]
    File.binwrite(image_path(@user.image_name), image.read)
  end

  def remove_image
    return unless ActiveRecord::Type::Boolean.new.cast(params[:user][:remove_img])

    File.delete(image_path(@user.image_name)) if @user.image_name && File.exist?(image_path(@user.image_name))
    @user.image_name = nil
  end

  def response_after_update(succeed_message, succeed_status, failed_render)
    return unless block_given?

    respond_to do |format|
      if yield
        format.html { redirect_to @user, notice: succeed_message }
        format.json { render :show, status: succeed_status, location: @user }
      else
        format.html { render failed_render }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
end
