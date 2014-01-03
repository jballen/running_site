class CreateRuns < ActiveRecord::Migration
  def change
    create_table :runs do |t|
      t.decimal :distance
      t.string :duration
      t.integer :user_id
      t.string :comment

      t.timestamps
    end
    add_index :runs, [:user_id, :created_at]
  end
end