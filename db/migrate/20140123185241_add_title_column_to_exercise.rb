class AddTitleColumnToExercise < ActiveRecord::Migration

  def self.up
    add_column :exercises, :title, :string
  end
  def self.down
    remove_column :exercises, :title
  end
end
