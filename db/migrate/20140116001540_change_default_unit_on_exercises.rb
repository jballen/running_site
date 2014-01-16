class ChangeDefaultUnitOnExercises < ActiveRecord::Migration
  def self.up
    change_column :exercises, :unit, :string, :default => "Miles"
  end

  def self.down
    # You can't currently remove default values in Rails
    raise ActiveRecord::IrreversibleMigration, "Can't remove the default"
  end
end
