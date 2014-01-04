class DropTableRuns < ActiveRecord::Migration
  def self.up
    drop_table :runs
  end
end
