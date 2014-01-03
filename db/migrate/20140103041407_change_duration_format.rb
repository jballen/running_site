class ChangeDurationFormat < ActiveRecord::Migration
  def self.up
    change_column :runs, :duration, :integer
  end

  def self.down
    change_column :runs, :duration, :string
  end
end
