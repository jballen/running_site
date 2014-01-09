class ChangeColumnTypeTeamCaptainsToText < ActiveRecord::Migration
  def self.up
    change_column :teams, :captains, :text   
  end 
  def self.down
    change_column :teams, :captains, :integer
  end
end
