class AddUserColumnToDayItems < ActiveRecord::Migration
  def self.up
    add_reference :day_items, :user, index: true
  end
  def self.down
    
  end
end
