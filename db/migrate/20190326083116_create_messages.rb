class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.integer :from_user_id, null: false
      t.integer :to_user_id, null: false
      t.text :content, null: false

      t.timestamps
    end
  end
end
