class CreateTeamUserRelationships < ActiveRecord::Migration
  def change
    create_table :team_user_relationships do |t|
      t.integer :user_id
      t.integer :team_id

      t.timestamps
    end
    add_index :team_user_relationships, :user_id
    add_index :team_user_relationships, :team_id
    add_index :team_user_relationships, [:user_id, :team_id], unique: true
  end
end
