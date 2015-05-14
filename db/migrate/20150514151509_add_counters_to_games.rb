class AddCountersToGames < ActiveRecord::Migration
  def change
    add_column :games, :stories_count, :integer, null: false, default: 0
  end
end
