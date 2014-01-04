class CreateExercises < ActiveRecord::Migration
  def change
    create_table :exercises do |t|
      t.decimal :distance
      t.integer :duration
      t.integer :user_id
      t.text :comment
      t.string :type
      t.date :activity_date

      t.timestamps
    end
    add_index :exercises, [:user_id, :created_at]
  end
end
