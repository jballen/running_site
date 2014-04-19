module ExercisesHelper
  def format_duration(duration)
    hours = duration.to_i/3600
    minutes = duration.to_i/60
    seconds = duration.to_i%60

    if hours > 0
      minutes = minutes%60 
    end
    
    minutes_string = minutes.to_s
    seconds_string = seconds.to_s
    hours_string = hours.to_s

    if minutes < 10
      minutes_string = '0' + (minutes).to_s
    end
    if seconds < 10
      seconds_string = '0' + seconds_string
    end
    if hours > 0
      return hours_string + ':' + minutes_string + ':' + seconds_string
    else
      return minutes_string + ':' + seconds_string
    end
  end

  def wrap(content)
    sanitize(raw(content.split.map{ |s| wrap_long_string(s) }.join(' ')))
  end

  def exercise_summary(exercise)
    summary = conjugate_verb_to_past_tense exercise.activity 
    if !exercise.distance.nil?
      summary = summary + ' ' + exercise.distance.round(2).to_s + ' miles in '
    else
      summary = summary + ' for '
    end 
  summary = summary + format_duration(exercise.duration)
  end

  def conjugate_verb_to_past_tense(verb)
    case verb
    when 'run'
      return 'ran'
    when 'swim'
      return 'swam'
    else
      return Verbs::Conjugator.conjugate verb,
                                         :tense => :past, 
                                         :person => :third, 
                                         :aspect => :perfective, 
                                         :plurality => :singular
    end
  end

  def format_activity_date(activity_date)
    if activity_date.nil?
      return 'unknown'
    end
    if Date.today() - activity_date == 0
      return 'today'
    else
      return pluralize((Date.today() - activity_date).to_i, 'day') + ' ago'
    end
  end

  private

    def wrap_long_string(text, max_width = 30)
      zero_width_space = "&#8203;"
      regex = /.{1,#{max_width}}/
      (text.length < max_width) ? text :
                                  text.scan(regex).join(zero_width_space)
    end
end
