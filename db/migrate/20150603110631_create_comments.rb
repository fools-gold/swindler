class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :user, index: true, null: false
      t.references :story, index: true, null: false
      t.text :body, null:false
      t.timestamps null: false
    end
    add_foreign_key :comments, :users, on_delete: :cascade
    add_foreign_key :comments, :stories, on_delete: :cascade
  end
end
