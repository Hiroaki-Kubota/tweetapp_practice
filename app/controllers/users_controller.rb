# frozen_string_literal: true

# User
class UsersController < ApplicationController
  before_action :set_user, only: %i[show likes edit update destroy image]
  before_action :authenticate_user, only: %i[index show likes edit update destroy]
  before_action :forbid_login_user, only: %i[new create login_form login]
  before_action :ensure_correct_user, only: %i[edit update destroy]

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
    update_image
    if @user.save
      create_succeed_response
    else
      create_failed_response
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    update_image

    if @user.update(user_params)
      update_succeed_response
    else
      update_failed_response
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'ユーザーを削除しました' }
      format.json { head :no_content }
    end
  end

  def login_form; end

  def login
    @user = User.find_by(email: params[:email])&.authenticate(params[:password])
    if @user
      login_succeed_response
    else
      login_failed_response
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to(:login, notice: 'ログアウトしました')
  end

  def likes
    @like_posts = Post.joins(:likes).where(likes: { user_id: @user.id }).order(created_at: :desc)
    # which is better?
    # @like_posts = @user.likes.inject([]) { |posts, like| posts << Post.find(like.post_id) }.sort { |a, b| b[:created_at] <=> a[:created_at] }
  end

  def image
    if @user&.image
      send_data(@user.image, type: @user.image_content_type, disposition: :inline)
    else
      default_image = UsersHelper.default_user_image
      send_data(default_image.image, type: default_image.content_type, disposition: :inline)
    end
  end

  private

  def create_succeed_response
    respond_to do |format|
      session[:user_id] = @user.id
      format.html { redirect_to :posts, notice: 'ユーザー登録が完了しました' }
      format.json { render :show, status: :created, location: @user }
    end
  end

  def create_failed_response
    respond_to do |format|
      format.html { render :new }
      format.json { render json: @user.errors, status: :unprocessable_entity }
    end
  end

  def update_succeed_response
    respond_to do |format|
      format.html { redirect_to @user, notice: 'ユーザー情報を編集しました' }
      format.json { render :show, status: :ok, location: @user }
    end
  end

  def update_failed_response
    respond_to do |format|
      format.html { render :edit }
      format.json { render json: @user.errors, status: :unprocessable_entity }
    end
  end

  def login_succeed_response
    session[:user_id] = @user.id
    respond_to do |format|
      format.html { redirect_to :posts, notice: 'ログインしました' }
      format.json { render :posts, status: :ok }
    end
  end

  def login_failed_response
    @email = params[:email]
    @password = params[:password]
    flash.now[:notice] = 'メールアドレスまたはパスワードが間違っています'
    respond_to do |format|
      format.html { render :login_form, notice: 'ログインしました' }
      format.json { render :posts, status: :ok }
    end
  end

  def update_image
    if ActiveRecord::Type::Boolean.new.cast(params[:user][:remove_image])
      unset_image
    elsif params[:user][:image]
      set_image
    end
  end

  def set_image
    @user.image = params[:user][:image].read
    @user.image_content_type = params[:user][:image].content_type
  end

  def unset_image
    @user.image = nil
    @user.image_content_type = nil
  end

  def ensure_correct_user
    redirect_to(:posts, notice: '権限がありません') if @current_user.id != params[:id].to_i
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find_by_id(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:name, :email, :image_name, :password)
  end
end
