class CreateDayItems < ActiveRecord::Migration
  def change
    create_table :day_items do |t|
      t.date :day
      t.string :title

      t.timestamps
    end
  end
end
