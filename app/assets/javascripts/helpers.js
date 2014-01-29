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
      var exercise = data[index]
      new_event['activity'] = exercise.activity;
      new_event['title'] = exercise.title;
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
      return data;
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
function setPopoverListeners(events_arr) {
  var patt1 = /[0-9]+/i;
  $.each(events_arr, function(index) {
    var e = events_arr[index];
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
      $('#exercise' + e.id).popover({content: comments, html:true})
    }
  });
}