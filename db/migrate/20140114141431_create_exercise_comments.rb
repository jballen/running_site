class CreateExerciseComments < ActiveRecord::Migration
  def change
    create_table :exercise_comments do |t|
      t.string :commenter
      t.text :body
      t.references :exercise, index: true

      t.timestamps
    end
  end
end
