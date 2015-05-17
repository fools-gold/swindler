class AddBioToUsers < ActiveRecord::Migration
  def change
    add_column :users, :bio, :string, null: false, default: ""
  end
end
