class RemoveDurationField < ActiveRecord::Migration
  def change
    remove_column :users, :duration
    add_column :users, :duration, :integer
  end
end
