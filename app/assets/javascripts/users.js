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
          new_event['unit'] = exercise.unit;
          new_event['user_id'] = exercise.user_id;
          new_event['user_name'] = exercise.user_name;
          new_event['comments'] = exercise.comments;
          new_event['id'] = exercise.id;
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
        var patt1 = /[0-9]+/i;
        $.each(events_arr, function(index) {
          var e = events_arr[index];
          var comments = '';
          $.each(e.comments, function(index) {
            console.log(e.comments[index].body)
            console.log(e.comments[index].commenter)
            var new_comment = '<div class="popover-comment">' +
                              e.comments[index].body + '</div>' +
                              '<div class="popover-comment-author">' +
                              e.comments[index].commenter +
                              '</div>';
            comments = comments + new_comment;
          });
          if (comments !== '') {
            $('#exercise' + e.id).popover({content: comments, html:true})
          }
        });
        $('.day-event').click(function(data) {
          data.stopPropagation();
          data.preventDefault();
          console.log('clicked event');
        });
        $('.fa-comment').click(function(data) {
          var patt1 = /[0-9]+/i;
          var exercise_id = data.currentTarget.id.match(patt1);
          data.stopPropagation();
          data.preventDefault();
          console.log(data);
          $('#exercise_comment_exercise_id').val(exercise_id);
          $('#comment-modal').modal('show');
        });
      });
    }
  });