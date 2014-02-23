$('document').ready(function() {
  if ($('body#teams').length) {
    $('.blog-post-edit').click(function(e) {
      e.preventDefault();
      $('#modal-title-edit').val($(e.target).data('post-id'))
      $('#post-edit-modal').modal('show');
    });
    $.when(getTeamMemberData()).done(function(users) {
      teamJavascript(users);
    });
    function teamJavascript(users) {
      var user_clndrs = {};
      var events_arr = {};
      var master_cal = $('#calendar-header').clndr({
        template: $('#calendar-header-template').html(),
        extras: {
          days: daysOfTheWeekFull,
          currentWeek: Math.floor( ( ( (moment().date() + moment().startOf('month').weekday() ) - 1 ) / ( weeksInMonth(moment() ) * 7) ) * weeksInMonth( moment() ) )
        },
        doneRendering: function() {
          $('.next-btn').on('click', function() {
            addUserEvents();
            setNextBtnListener(master_cal);            
          });
          $('.previous-btn').on('click', function() {
            addUserEvents();
            setPrevBtnListener(master_cal);
          });
        }
      });

      /* Creates a new 'clndr' for each user on the team. */
      generateUserCalendars();
      
      function addUserEvents() {
        $.when(getTeamDataInWeek(getStartDay(), getEndDay)).done(function(user_events) {
          $.each(user_events, function(key) {
            var user = user_events[key];
            events_arr[user.id] = user.exercises;
            user_clndrs[user.id].setEvents(user.exercises);
          });
        });
      }

      function getStartDay() {
        var dateInfo = new Date($('.clndr-info').data('start-day'));
        dateInfo.setDate(dateInfo.getDate()-14);
        var day = dateInfo.getUTCDate().toString();
        var month = (dateInfo.getUTCMonth()+1).toString();
        var year = dateInfo.getUTCFullYear().toString();
        return year + '-' + month + '-' + day;
      }

      function getEndDay() {
        var dateInfo = new Date($('.clndr-info').data('end-day'));
        dateInfo.setDate(dateInfo.getDate()+14);
        var day = dateInfo.getUTCDate().toString();
        var month = (dateInfo.getUTCMonth()+1).toString();
        var year = dateInfo.getUTCFullYear().toString();
        return year + '-' + month + '-' + day;  
      }

      function generateUserCalendars() {
        $.when(getTeamDataInWeek(getStartDay(), getEndDay())).done(function(user_events) {
          $.each(user_events, function(key) {
            var user = user_events[key];
            events_arr[user.id] = user.exercises;
            var cal = $('#calendar' + user.id).clndr({
              template: $('#calendar-template' + user.id).html(),
              events: events_arr[user.id],
              extras: {
                currentWeek: Math.floor( ( ( (moment().date() + moment().startOf('month').weekday() ) - 1 ) / ( weeksInMonth(moment() ) * 7) ) * weeksInMonth( moment() ) )
              },
              showAdjacentMonths: true,
              ready: function() {
      
              },
              doneRendering: function() {
                setUpCommentListeners(events_arr[user.id]);
                setTotals(user.id);
                /* Next button handler */
                $('.next-btn').on('click', function() {
                  setNextBtnListener(cal);
                });

                /* Previous button handler */
                $('.previous-btn').on('click', function() {
                  setPrevBtnListener(cal);
                });
              }
            });
            user_clndrs[user.id] = cal;
          });
        });
      }
      function setTotals(id) {
        var cal = $('#calendar' + id);
        var events = cal.find('.day-event');
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
        var total_div = $('.users-total' + id);
        $.each(totals, function(key) {
          total_div.append(key + ': ' + totals[key].toFixed(2) + ' miles<br>');
        });
      }
      function getCurrentWeek() {
        return Math.floor( ( ( (moment().date() + moment().startOf('month').weekday() ) - 1 ) / ( weeksInMonth(moment() ) * 7) ) * weeksInMonth( moment() ) )
      }

      function weeksInMonth(month) {
        return Math.floor((month.daysInMonth() + moment(month).startOf('month').weekday()) / 7);
      }

      function setNextBtnListener(cal) {
        var weeks_in_month = weeksInMonth(cal.month) - 1;

        if(cal.options.extras.currentWeek < weeks_in_month) {
          /* Increase the week count */
          cal.options.extras.currentWeek += 1;
          cal.render();
        } else if(cal.options.extras.currentWeek > weeks_in_month) {
          /* If we started at the last week of the month, we want to skip over currentWeek = 0 */
          cal.options.extras.currentWeek = 1;
          cal.next();
        } else {
          /* Reset the week count */
          cal.options.extras.currentWeek = 0;

          /* Go to next month */
          cal.next();
        }
      }

      function setPrevBtnListener(cal) {
        /* if we're just counting down we don't need to know the weeks in the month... */
        if(cal.options.extras.currentWeek > 0) {
          /* Decrease the week count */
          cal.options.extras.currentWeek -= 1;
          cal.render();
        }
        /* however if we've crossed 0, we need weeks_in_month to reflect LAST month
        before clndr has had a chance to go back. */
        else {
          var weeks_in_month = weeksInMonth( moment(cal.month).subtract('month', 1) ) - 1;
          /* Reset the week count */
          cal.options.extras.currentWeek = weeks_in_month;

          /* Go to previous month */
          cal.back();
        }
      }
    } 
  }
});
