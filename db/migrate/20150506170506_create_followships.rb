class CreateFollowships < ActiveRecord::Migration
  def change
    create_table :followships do |t|
      t.references :follower, index: true, null: false
      t.references :followed, index: true, null: false

      t.timestamps null: false
    end
    add_foreign_key :followships, :users, column: "follower_id", on_delete: :cascade
    add_foreign_key :followships, :users, column: "followed_id", on_delete: :cascade

    add_index :followships, [:follower_id, :followed_id], unique: true
  end
end
