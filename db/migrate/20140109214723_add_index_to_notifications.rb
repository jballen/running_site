class AddIndexToNotifications < ActiveRecord::Migration

  def self.up
    add_index :notifications, :user_id
  end
end
