class AddStoryCountersToUsers < ActiveRecord::Migration
  def change
    add_column :users, :stories_count, :integer, null: false, default: 0
    add_column :users, :stories_of_count, :integer, null: false, default: 0
  end
end
