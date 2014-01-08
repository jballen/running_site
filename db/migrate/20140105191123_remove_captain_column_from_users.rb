class RemoveCaptainColumnFromUsers < ActiveRecord::Migration
  def self.up
    remove_column :users, :captain
  end
  def self.down
    add_column :users, :captain, :integer
  end
end
