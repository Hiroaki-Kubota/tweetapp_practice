# frozen_string_literal: true

# Controller for Posts
class PostsController < ApplicationController
  attr_accessor :posts
  attr_accessor :post

  def index
    self.posts = Post.all
  end

  def show
    self.post = Post.find(params[:id])
  end
end
