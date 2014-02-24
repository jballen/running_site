/***********************/
/*    Variables        */
/***********************/
var daysOfTheWeekFull = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 
                         'Thursday', 'Friday', 'Saturday']

function getEventsArray(url) {
  var events_arr = [];
  return $.getJSON(url, function(data) {
    $.each(data, function(index) {
      var new_event = {};
      var day_item = data[index];
      new_event['title'] = day_item.title;
      new_event['date'] = day_item.date;
      new_event['exercises'] = [];
      $.each(day_item.exercises, function(ex_index) {
        var exercise = day_item.exercises[ex_index];
        var new_exercise = {};
        new_exercise['activity'] = exercise.activity;
        new_exercise['duration'] = exercise.duration;
        new_exercise['distance'] = exercise.distance;
        new_exercise['unit'] = exercise.unit;
        new_exercise['user_id'] = exercise.user_id;
        new_exercise['user_name'] = exercise.user_name;
        new_exercise['comments'] = exercise.comments;
        new_exercise['id'] = exercise.id;
        new_event['exercises'].push(new_exercise);
      });
      events_arr.push(new_event);
    });
  });
}

function getTeamMemberData() {
  return $.getJSON(document.URL + '/list_team_member_data', function(data) {
  });
}
function getTeamDataInWeek(startDay, endDay) {
  return $.getJSON(document.URL + '/get_team_data_in_week', 
    {"startDay": startDay, "endDay": endDay},
    function(data) {
    });
}
function setUpCommentListeners(events_arr) {
  setPopoverListeners(events_arr);
  $('.fa-comment').click(function(data) {
    var patt1 = /[0-9]+/i;
    var exercise_id = data.currentTarget.id.match(patt1);
    data.stopPropagation();
    data.preventDefault();
    $('#exercise_comment_exercise_id').val(exercise_id);
    $('#comment-modal').modal('show');
  });
}
function setPopoverListeners(day_items) {
  var patt1 = /[0-9]+/i;
  $.each(day_items, function(index) {
    var day_item = day_items[index];
    $.each(day_item.exercises, function(di_index) {
      var e = day_item.exercises[di_index];
      var comments = '';
      $.each(e.comments, function(index) {
        var commenter_name = e.comments[index].commenter_name || e.comments[index].commenter_email;
        var new_comment = '<div class="popover-comment">' +
                          e.comments[index]['body'] + '</div>' +
                          '<div class="popover-comment-author">' +
                          commenter_name + '</div>';
        comments = comments + new_comment;
      });
      if (comments !== '') {
        $('#exercise' + e.id).popover({placement: 'left', content: comments, html:true})
      }
    });
  });
}