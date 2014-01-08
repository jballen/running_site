class RemoveTeamIdFromTeamTable < ActiveRecord::Migration

  def self.up
    remove_column :teams, :team_id
  end
  def self.down
    add_column :teams, :team_id, :integer
  end 
end
