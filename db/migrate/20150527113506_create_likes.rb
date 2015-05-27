class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.references :user, index: true, null: false
      t.references :story, index: true, null: false

      t.timestamps null: false
    end
    add_foreign_key :likes, :users, on_delete: :cascade
    add_foreign_key :likes, :stories, on_delete: :cascade

    add_index :likes, [:user_id, :story_id], unique: true
    add_index :likes, [:story_id, :user_id], unique: true
  end
end
