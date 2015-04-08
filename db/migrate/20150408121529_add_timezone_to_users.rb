class AddTimezoneToUsers < ActiveRecord::Migration
  def change
    add_column :users, :timezone, :string

    User.find_each do |user|
      user.update timezone: "UTC"
    end

    change_column_null :users, :timezone, false
  end
end
