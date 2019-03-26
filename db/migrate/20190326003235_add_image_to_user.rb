# frozen_string_literal: true

class AddImageToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :image, :binary, limit: 10.megabyte
    add_column :users, :image_content_type, :string
  end
end
