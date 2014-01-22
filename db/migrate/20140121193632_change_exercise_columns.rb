class ChangeExerciseColumns < ActiveRecord::Migration
  def self.up
    rename_column :exercise_comments, :commenter, :commenter_email
    add_column :exercise_comments, :commenter_name, :string
  end
  def self.down
    rename_column :exercise_comments, :commenter_email, :commenter
    remove_column :exercise_comments, :commenter_name
  end
  end
