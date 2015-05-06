class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :title, null: false
      t.string :slug

      t.timestamps null: false
    end
    add_index :games, :slug, unique: true
  end
end
