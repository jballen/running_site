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
      var user_clndrs = [];
      var master_cal = $('#calendar-header').clndr({
        template: $('#calendar-header-template').html(),
        extras: {
          days: daysOfTheWeekFull,
          currentWeek: Math.floor( ( ( (moment().date() + moment().startOf('month').weekday() ) - 1 ) / ( weeksInMonth(moment() ) * 7) ) * weeksInMonth( moment() ) )
        },
        doneRendering: function() {
          $('.next-btn').on('click', function() {
            setNextBtnListener(master_cal);
            console.log(master_cal.month)
            var month = master_cal.month;
            var endDay = month.add('day', master_cal.options.extras.currentWeek*7);
            var startDay = month.add('day', master_cal.options.extras.currentWeek*7-6);
            var user_events = getTeamDataInWeek(startDay.format('YYYY-MM-DD'), endDay.format('YYYY-MM-DD'));
            console.log(user_events);
          });
          $('.previous-btn').on('click', function() {
            setPrevBtnListener(master_cal);
            // var endDay = (new Date(master_cal.month.add('days', master_cal.options.extras.currentWeek*7))).toISOString();
            // var startDay = (new Date(master_cal.month.add('days', master_cal.options.extras.currentWeek*7 - 6))).toISOString();
            // console.log(startDay);
            // var user_events = getTeamDataInWeek(startDay, endDay);
          });
        }
      });

      /* Creates a new 'clndr' for each user on the team. */
      $.each(users, function(index) {
        user_clndrs.push(generateNewCalendar(users[index]));
      });

      function generateNewCalendar(user) {
        var cal = $('#calendar' + user.id).clndr({
          template: $('#calendar-template' + user.id).html(),
          events: user.exercises,
          extras: {
            currentWeek: Math.floor( ( ( (moment().date() + moment().startOf('month').weekday() ) - 1 ) / ( weeksInMonth(moment() ) * 7) ) * weeksInMonth( moment() ) )
          },
          showAdjacentMonths: true,
          doneRendering: function() {
            /* Next button handler */
            $('.next-btn').on('click', function() {
              setNextBtnListener(cal);
            });

            /* Previous button handler */
            $('.previous-btn').on('click', function() {
              setPrevBtnListener(cal);
            });
            setUpCommentListeners(user.exercises)
            return cal;
          }
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
