class CreateTeamGoals < ActiveRecord::Migration
  def change
    create_table :team_goals do |t|
      t.references :team, index: true
      t.date :start_date
      t.date :end_date
      t.decimal :distance
      t.integer :duration
      t.string :activity
      t.string :title

      t.timestamps
    end
  end
end
