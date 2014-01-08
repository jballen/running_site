class AddTeamsColumnToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :teams, :integer
  end

  def self.down
    remove_column :users, :teams
  end
end
