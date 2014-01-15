class AddMetricToDistance < ActiveRecord::Migration
  def self.up
    add_column :exercises, :unit, :string
  end
  def self.down
    remove_column :exercises, :unit
  end
end
