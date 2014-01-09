class AddCaptainsColumnToTeams < ActiveRecord::Migration

  def self.up
    rename_column :teams, :captain, :captains
  end
  def self.down
    rename_column :teams, :captains, :captain
    
  end
end
