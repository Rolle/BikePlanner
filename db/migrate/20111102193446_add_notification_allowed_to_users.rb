class AddNotificationAllowedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :notification_allowed, :boolean, :default => false
  end
end
