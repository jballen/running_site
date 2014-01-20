$('document').ready(function() {
    if ($('body#teams').length) {
        $.getJSON(document.URL + '/list_team_exercises', function(data) {
            var events_arr = [];
            $.each(data, function(index) {
              var new_event = {};
              var exercise = data[index]
              new_event['activity'] = exercise.activity;
              new_event['date'] = exercise.date;
              new_event['duration'] = exercise.duration;
              new_event['distance'] = exercise.distance;
              new_event['unit'] = exercise.unit || 'miles';
              new_event['user_id'] = exercise.user_id;
              new_event['user_name'] = exercise.user_name;
              new_event['id'] = exercise.id;
              events_arr.push(new_event);
            });
            
          function weeksInMonth(month) {
              return Math.floor((month.daysInMonth() + moment(month).startOf('month').weekday()) / 7);
          }

          var iphone_cal = $('#clndr').clndr({
              template: $('#clndr_template').html(),
              extras: {
                  currentWeek: Math.ceil( weeksInMonth( moment() ) * ( moment().date() / moment().daysInMonth() ) )
              },
              showAdjacentMonths: true,
              doneRendering: function() {
                  /* Event click handler */
                  $('.day-event').on('click', function() {
                    $('#comment-modal').modal('show');
                    console.log('clicked');
                  });
                  /* Next button handler */
                  $('.next-btn').on('click', function() {
                      /* Get numbers of weeks in the month */
                      var weeks_in_month = weeksInMonth(iphone_cal.month) - 1;

                      if(iphone_cal.options.extras.currentWeek < weeks_in_month) {
                          /* Increase the week count */
                          iphone_cal.options.extras.currentWeek += 1;
                          iphone_cal.render();
                      } else if(iphone_cal.options.extras.currentWeek > weeks_in_month) {
                          /* If we started at the last week of the month, we want to skip over currentWeek = 0 */
                          iphone_cal.options.extras.currentWeek = 1;
                          iphone_cal.next();
                      } else {
                          /* Reset the week count */
                          iphone_cal.options.extras.currentWeek = 0;

                          /* Go to next month */
                          iphone_cal.next();
                      }
                  });

                  /* Previous button handler */
                  $('.previous-btn').on('click', function() {
                      /* if we're just counting down we don't need to know the weeks in the month... */
                      if(iphone_cal.options.extras.currentWeek > 0) {
                          /* Decrease the week count */
                          iphone_cal.options.extras.currentWeek -= 1;
                          iphone_cal.render();
                      }
                      /* however if we've crossed 0, we need weeks_in_month to reflect LAST month
                         before clndr has had a chance to go back. */
                      else {
                          var weeks_in_month = weeksInMonth( moment(iphone_cal.month).subtract('month', 1) ) - 1;
                          /* Reset the week count */
                          iphone_cal.options.extras.currentWeek = weeks_in_month;

                          /* Go to previous month */
                          iphone_cal.back();
                      }
                  });
                  $.each(events_arr, function(index) {
                    var new_event = events_arr[index];
                    var day_object = $('#' + new_event.user_id + '.days .calendar-day-' + new_event.date);
                    day_object.addClass('event');
                    day_object.append('<div class="day-event" id="exercise' + new_event.id + '">' +
                                        '<span class="event-type">'+  new_event.activity + ':</span>' + 
                                        '<span class="event-duration">' +  new_event.duration + ', </span>' +
                                        '<span class="event-distance">' +  new_event.distance + '</span>' + 
                                        '<span class="event-unit"> ' + new_event.unit + '</span>' + 
                                      '</div>');
                    $('.day-event#exercise' + new_event.id).on('click', function() {
                      $('#comment-modal').modal('show');
                      $('#exercise_comment_exercise_id').val(new_event.id);
                      console.log('clicked');
                    });
              
                  });
              }
          });
        }); 
    }
});