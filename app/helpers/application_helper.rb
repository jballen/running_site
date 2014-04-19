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

  def format_day_item_for_json(day_item, user)
    @new_day_item = {}
    @new_day_item['title'] = day_item.title
    @new_day_item['date'] = day_item.day
    @new_day_item['user_id'] = user.id
    @new_day_item['exercises'] = []
    day_item.exercises.each do |exercise|
      @new_exercise = {}
      @new_exercise['duration'] = format_duration(exercise.duration)
      @new_exercise['distance'] = exercise.distance
      @new_exercise['activity'] = exercise.activity
      @unit = exercise.unit || "mile"
      @new_exercise['unit'] = @unit.pluralize(exercise.distance.round(2)) unless exercise.distance.nil?
      @new_exercise['id'] = exercise.id
      @new_exercise['comments'] = exercise.exercise_comments
      @new_day_item['exercises'] << @new_exercise
    end
    return @new_day_item
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
    @new_exercise['title'] = exercise.title
    return @new_exercise
  end
    
end