class RemoveTeamsColumnFromUsers < ActiveRecord::Migration

  def self.up
    remove_column :users, :teams
  end
  def self.down
    add_column :users, :teams, :integer
  end
end
