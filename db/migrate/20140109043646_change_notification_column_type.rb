class ChangeNotificationColumnType < ActiveRecord::Migration

  def self.up
    rename_column :notifications, :type, :what
  end
  def self.down
    rename_column :notifications, :what, :type
  end
end
