module RunsHelper
  def format_duration(duration)
    hours = duration/3600
    minutes = duration/60
    seconds = duration%60

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

  private

    def wrap_long_string(text, max_width = 30)
      zero_width_space = "&#8203;"
      regex = /.{1,#{max_width}}/
      (text.length < max_width) ? text :
                                  text.scan(regex).join(zero_width_space)
    end
end
