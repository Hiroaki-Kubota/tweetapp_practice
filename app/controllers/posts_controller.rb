# frozen_string_literal: true

# Controller for Posts
class PostsController < ApplicationController
  attr_accessor :posts

  def index
    self.posts = Post.all
  end
end
