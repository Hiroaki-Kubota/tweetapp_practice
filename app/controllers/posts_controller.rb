# frozen_string_literal: true

# Controller for Posts
class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]
  attr_accessor :posts
  attr_accessor :post

  def index
    self.posts = Post.all
  end

  def show; end

  def new
    self.post = Post.new
  end

  def create
    self.post = Post.new(post_params)
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

  def set_post
    self.post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:content)
  end
end