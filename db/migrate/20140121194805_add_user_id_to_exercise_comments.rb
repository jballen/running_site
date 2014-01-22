class AddUserIdToExerciseComments < ActiveRecord::Migration

  def self.up
    add_column :exercise_comments, :user_id, :integer    
  end
  def self.down
    remove_column :exercise_comments, :user_id
  end
end

