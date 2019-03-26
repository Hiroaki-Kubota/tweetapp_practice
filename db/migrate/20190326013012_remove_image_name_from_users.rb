# frozen_string_literal: true

class RemoveImageNameFromUsers < ActiveRecord::Migration[5.2]
  def up
    remove_column :users, :image_name
  end

  def down
    add_column :users, :image_name, :string
  end
end
