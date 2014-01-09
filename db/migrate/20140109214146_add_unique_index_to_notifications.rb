class AddUniqueIndexToNotifications < ActiveRecord::Migration
  def self.up
    add_index :notifications, [:user_id, :team_id], unique: true
  end

end
