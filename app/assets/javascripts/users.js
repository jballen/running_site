  $('document').ready(function() {
    if ($('body#users').length) {
      $.when(getEventsArray(document.URL + '/list_exercises')).done(function(data) {
        userJavascript(data);
      });

      function userJavascript(events_arr) {
        $('.calendar').clndr({
          template: $('#calendar-template').html(),
          events: events_arr,
          extras: { 
            days: daysOfTheWeekFull
          },
          clickEvents: {
            click: function(target) {
              var date = target.date._i;
              $('#exercise_activity_date').val(date)
              $('#exercise-modal').modal('show')
            }
          },
          doneRendering: function() {
            setPopoverListeners(events_arr);
            
            $('.day-event').click(function(data) {
              data.stopPropagation();
              data.preventDefault();
            });
            $('.fa-comment').click(function(data) {
              var patt1 = /[0-9]+/i;
              var exercise_id = data.currentTarget.id.match(patt1);
              data.stopPropagation();
              data.preventDefault();
              $('#exercise_comment_exercise_id').val(exercise_id);
              $('#comment-modal').modal('show');
            });
          } 
        });
      }
    }
  });