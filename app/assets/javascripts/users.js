// $('document').ready(function() {
//   if ($('body#users').length) {
//     $('#calendar').fullCalendar({
//       header: {
//         center: 'title',
//         right: 'month,basicWeek',
//         left: 'prev,next today'
//       },
//       weekMode: 'liquid',
//       eventMouseover: function(event, jsEvent, view) {
//         renderEventPopup(event, jsEvent, view);
//       },
//       eventMouseout: function(event, jsEvent, view) {
//         closeEventPopup(event, jsEvent, view);
//       }
//     })
//     $.getJSON(document.URL + '/list_exercises', function(data) {
//       for (var index in data) {
//         var activityId = 'activity' + data[index].id;
//         $('#calendar').fullCalendar('renderEvent', {
//           title: data[index].activity + ' (' + data[index].distance + ')',
//           start: data[index].activity_date,
//           end:   data[index].activity_date,
//           id:    activityId
//         }, true);
//       }
//     });
//   }
// });
// function renderEventPopup(event, jsEvent, view) {
//   console.log(event)
//   console.log(jsEvent)
//   console.log(view);
//   var popup = $('#event_popup');
//   var description = $('#event_popup .description');
//   var comment = $('#event_popup .comment');
//   var title = $('#event_popup .title');
//   title.innerHTML('Test');
//   $('#event_popup').css('display', 'inline');
// }
// function closeEventPopup(event, jsEvent, view) {
//   $('#event_popup').css('display', 'none');
// }
var events_arr = [];
$.getJSON(document.URL + '/list_exercises', function(data) {
  $.each(data, function(index) {
    console.log(data[index])
    var new_event = {};
    var exercise = data[index]
    new_event['activity'] = exercise.activity;
    new_event['date'] = exercise.date;
    new_event['duration'] = exercise.duration;
    new_event['distance'] = exercise.distance;
    new_event['unit'] = exercise.unit || 'miles';
    events_arr.push(new_event);
  });
  $('#calendar').clndr({
    template: $('#calendar-template').html(),
    events: events_arr
  });
});