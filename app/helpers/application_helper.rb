module ApplicationHelper
  include ActionView::Helpers::TextHelper

  # Returns the full title on a per-page basis.
  def fullTitle(page_title)
    base_title = "LogAJog"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def format_exercise_for_json(exercise, user)
    @new_exercise = {}
    @new_exercise['duration'] = format_duration(exercise.duration)
    @new_exercise['distance'] = exercise.distance
    @new_exercise['activity'] = exercise.activity
    @unit = exercise.unit || "mile"
    @new_exercise['unit'] = @unit.pluralize(exercise.distance.round(2)) unless exercise.distance.nil?
    @new_exercise['date'] = exercise.activity_date
    @new_exercise['user_id'] = user.id
    @new_exercise['user_name'] = user.name
    @new_exercise['id'] = exercise.id
    @new_exercise['comments'] = exercise.exercise_comments
    return @new_exercise
  end
end