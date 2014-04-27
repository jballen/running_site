  $('document').ready(function() {
    if ($('body#users').length) {
      $.getJSON('http://ec2-54-85-55-223.compute-1.amazonaws.com/get_user_data_for_day?day=2014-04-13&email=kmmurphy@gmail.com', function(data) {
        console.log(data);
      });
      $('.duration-minutes').focusout(function(data) {
        setPace();
      });
      $('.duration-seconds').focusout(function(data) {
        setPace();
      });
      $('.duration-hours').focusout(function(data) {
        setPace();
      });
      $('.distance-input').focusout(function(data) {
        if ($('.duration-hours').val() > 0 || $('.duration-minutes').val() > 0 || $('.duration-seconds').val() > 0)
          $('.pace').html('Pace: ' + calculatePace() );
      });

      $.when(getEventsArray(document.URL + '/get_day_items')).done(function(data) {
        userJavascript(data);
      });
      function setPace() {
        if ($('.distance-input').val() > 0)
          $('.pace').html('Pace: ' + calculatePace() );
      }
      function calculatePace() {
        var distance = $('.distance-input').val();
        var hours = parseInt($('.duration-hours').val()) || 0;
        var minutes = parseInt($('.duration-minutes').val()) || 0;
        var seconds = parseInt($('.duration-seconds').val()) || 0;
        var total_seconds = hours*3600 + minutes*60 + seconds;
        var pace = total_seconds/distance;
        var pace_minutes = Math.round(pace/60);
        var pace_seconds = Math.round(pace%60);
        if (pace_seconds < 10) { 
          pace_seconds = '0' + pace_seconds;
        }
        return pace_minutes + ':' + pace_seconds;
      }
      /* Calculates the totals for every week */
      function calculateTotals() {
        var week_no = 0;
        for (var week_no = 0; week_no < 5; week_no++) {
          var weeks = $('.week' + week_no);
          var events = weeks.find('.day-event');
          var totals = {};
          $.each(events, function(key) {
            var e = $(events[key]);
            var type = e.attr('data-activity');
            if (totals[type] === undefined) 
              totals[type] = 0;
            var distance = parseFloat(e.attr('data-distance'));
            var unit = e.attr('data-unit');
            if (unit === 'kms' || unit === 'km')
              distance = distance * 0.621371;
            totals[type] = totals[type] + distance;
          });
          var total_div = $('.users-total.week' + week_no);
          $.each(totals, function(key) {
            total_div.append(key + ': ' + totals[key].toFixed(2) + ' miles<br>');
          });
        }
      }
      function userJavascript(day_items) {
        $('.calendar').clndr({
          template: $('#calendar-template').html(),
          events: day_items,
          extras: { 
            days: daysOfTheWeekFull
          },
          clickEvents: {
            click: function(target) {
              var date = target.date._i;
              console.log(target);
              $('#day_item_day').val(date);
              $('#exercise-modal').modal('show');
            }
          },
          doneRendering: function() {
            setPopoverListeners(day_items);
            calculateTotals();
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
