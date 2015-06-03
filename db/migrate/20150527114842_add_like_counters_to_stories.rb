class AddLikeCountersToStories < ActiveRecord::Migration
  def change
    add_column :stories, :likes_count, :integer, null: false, default: 0

    Story.find_each { |story| Story.reset_counters(story.id, :likes) }
  end
end
