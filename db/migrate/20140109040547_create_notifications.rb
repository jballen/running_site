class CreateNotifications < ActiveRecord::Migration
  def self.up
    create_table :notifications do |t|
      t.references :team, index: true
      t.string :type
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down

  end
end
