class AddCommentToRuns < ActiveRecord::Migration
  def self.up
    change_column :runs, :comment, :text
  end

  def self.down
    change_column :runs, :comment, :string
  end
end
