class ChangeDefaultUnitInExerciseTable < ActiveRecord::Migration

  def self.up
    change_column :exercises, :unit, :default => "mile"
  end
end
