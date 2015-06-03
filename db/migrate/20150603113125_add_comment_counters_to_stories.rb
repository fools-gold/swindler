class AddCommentCountersToStories < ActiveRecord::Migration
  def change
    add_column :stories, :comments_count, :integer, null: false, default: 0

    Story.find_each { |story| Story.reset_counters(story.id, :comments) }
  end
end
