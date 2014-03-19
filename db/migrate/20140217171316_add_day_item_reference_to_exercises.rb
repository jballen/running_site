class AddDayItemReferenceToExercises < ActiveRecord::Migration
  def change
    add_reference :exercises, :day_item, index: true
  end
end
