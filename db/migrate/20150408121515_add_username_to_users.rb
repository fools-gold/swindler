class AddUsernameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :username, :string

    User.find_each do |user|
      user.update username: user.email.split("@").first
    end

    change_column_null :users, :username, false
  end
end
