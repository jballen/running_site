class ExerciseComment < ActiveRecord::Base
  belongs_to :exercise
  has_one :user
end
