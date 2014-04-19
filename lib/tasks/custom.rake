namespace :logarun do 
  desc "Imports a target user's data from logarun"
  task :import, [:logarun_name, :user_email] => :environment do |t, args| 
    require 'nokogiri'
    require 'open-uri'
    puts 'Importing data for: '
    puts 'LogARun user: ' + args.logarun_name
    puts 'User email: ' + args.user_email

    url = "http://www.logarun.com/xml.ashx?username=" + args.logarun_name + "&type=view"
    doc = Nokogiri::XML(open(url))
    user = User.find_by(:email => args.user_email)
    day_items = doc.xpath('//dayItem')
    day_items.each do |day_item| 
      @day_item = DayItem.new(
        :day => convert_to_date(day_item.attr('date')),
        :user_id => user.id
      )
      @day_item.exercises = []
      puts '********** NEW DAY ***********'
      exercises = day_item.css('item')
      exercises.each do |exercise|
        duration = exercise.attr('value3')
        if duration.nil? || duration.empty? 
          duration = exercise.attr('value2')
        end
        puts duration
        if duration == nil || duration
          duration = 0.0
        end
        if (distance =exercise.attr('value1')) == 0
          distance = nil
        end
        @exercise = Exercise.new(
          :distance => distance,
          :duration => duration,
          :user_id => user.id,
          :activity => translate_activity(exercise.attr('exercise')),
          :activity_date => convert_to_date(day_item.attr('date')),
          :unit => :mile
        )
        if @exercise.save
          puts 'Saved exercise!'
          @day_item.exercises << @exercise
        else
          puts 'Unable to save exercise'
          puts @exercise.activity_date
          puts @exercise.distance
          puts @exercise.duration
          puts @exercise.user_id
          puts @exercise.activity
          puts @exercise.unit

        end
      end
      if @day_item.save
        puts 'Saved new day item for ' + day_item.attr('date')
      else
        puts 'Save failed!'
      end
    end
  end 

  def convert_to_date(date) 
    format = "%m/%d/%Y"
    return Date.strptime(date, format)
  end

  def translate_activity(activity) 
    case activity
    when "Run"
      return :run
    when "Elliptical"
      return :elliptical
    when "Bike"
      return :bike
    when "NordicSkiing"
      return :nordicskiing
    when "Hike"
      return :hike
    when "Swim"
      return :swim
    end
  end
end
