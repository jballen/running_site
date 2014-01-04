class TypeToActivityType < ActiveRecord::Migration
  def self.up
    rename_column :exercises, :type, :what
  end

  def self.down
    rename_column :exercises, :what, :type
  end
end
