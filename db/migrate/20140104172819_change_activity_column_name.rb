class ChangeActivityColumnName < ActiveRecord::Migration
  def self.up
    rename_column :exercises, :what, :activity
  end

  def self.down
    rename_column :exercises, :activity, :what
  end
end
