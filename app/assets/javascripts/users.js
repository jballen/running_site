  $('document').ready(function() {
    if ($('body#users').length) {
      var events_arr = [];
      $.getJSON(document.URL + '/list_exercises', function(data) {
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
          events_arr.push(new_event);
        });
        $('#calendar').clndr({
          template: $('#calendar-template').html(),
          events: events_arr,
          clickEvents: {
            click: function(target) {
              var date = target.date._i;
              $('#exercise_activity_date').val(date)
              $('#exercise-modal').modal('show')
            }
          }
        });
        $('.day-event').click(function() {
          console.log('clicked event');
        });
      });
    }
  });