# frozen_string_literal: true

# Controller for Posts
class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]
  before_action :authenticate_user
  before_action :ensure_correct_user, only: %i[edit update destroy]
  attr_accessor :posts
  attr_accessor :post

  def index
    self.posts = Post.all.order(created_at: :desc)
  end

  def show
    @likes_count = Like.where(post_id: @post.id).count
  end

  def new
    self.post = Post.new
  end

  def create
    post = Post.new(post_params)
    post.user_id = @current_user.id
    respond_to do |format|
      if post.save
        format.html { redirect_to :posts, notice: '投稿を作成しました' }
        format.json { render :show, status: :created, location: post }
      else
        format.html { render :new }
        format.json { render json: post.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if post.update(post_params)
        format.html { redirect_to :posts, notice: '投稿を更新しました' }
        format.json { render :show, status: :ok, location: post }
      else
        format.html { render :edit }
        format.json { render json: post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    post.destroy
    respond_to do |format|
      format.html { redirect_to :posts, notice: '投稿を削除しました' }
      format.json { head :no_content }
    end
  end

  private

  def ensure_correct_user
    @post = Post.find_by(id: params[:id])
    redirect_to(:posts, notice: '権限がありません') unless @post.user_id == @current_user.id
  end

  def set_post
    self.post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:content, :user_id)
  end
end
