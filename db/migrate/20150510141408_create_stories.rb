class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.text :body, null: false
      t.references :by, index: true, null: false
      t.references :of, index: true, null: false
      t.references :game, index: true, null: false

      t.timestamps null: false
    end
    add_foreign_key :stories, :users, column: "by_id", on_delete: :cascade
    add_foreign_key :stories, :users, column: "of_id", on_delete: :cascade
    add_foreign_key :stories, :games, on_delete: :cascade

    add_index :stories, [:by_id, :of_id, :game_id]
    add_index :stories, [:by_id, :of_id]
  end
end
