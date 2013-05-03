module ToursHelper

  	def tour_on_day(tours, day)  
      tours_on_day = []		
  		tours.each do |tour|
  			if (tour.start_at.day == day.day && tour.start_at.month == day.month && tour.start_at.year == day.year)
  				tours_on_day << tour
  			end
  		end

      return false if tours_on_day.size == 0
  		tours_on_day
  	end
    
    def icon(tour)
      if tour.tour_type == "MTB"
        "<i class='icon-picture'></i>" 
      else
        "<i class='icon-road'></i>" 
      end
    end

    def tour_overview(tours, day)
      markup = []
      html = "<b>"+day.day.to_s+"</b><br/>"
      now = DateTime.now
      class_unrated = false
      tours.each do |t|           
          if signed_in?
            #html << icon(t) + "<a data-toggle='modal' href='#modal_tour"+t.id.to_s+"'>"+t.start_at.strftime("%H:%M") + ", " +t.route + ", " +t.duration.to_s + " min.</a><br/>"
            html << icon(t) + "<a rel='popover' data-placement='bottom' data-trigger='hover' data-toggle='modal' href='#modal_tour"+t.id.to_s+"' data-content='"+twipsy_text(t)+"' data-original-title='"+twipsy_title(t)+"'> "+t.start_at.strftime("%H:%M") + ", " +t.route + ", " +t.duration.to_s + " min.</a><br/>"          
          else
            html << icon(t) + " " + t.start_at.strftime("%H:%M") + ", " +t.route + ", " +t.duration.to_s + " min.<br/>"
          end
          class_unrated = true if !t.rated? and t.start_at < now
      end
      markup << html
      if class_unrated
        markup << {:class => 'dayWithEventsNotClosed'}
      else
        markup << {:class => 'dayWithEvents'}
      end
      markup      
    end

  	def twipsy_text(tour)
  		t = "Abfahrt: " + tour.meeting_point + " mit " + tour.tour_type + ", Dauer: " + tour.duration.to_s +
      "min, Strecke: " + tour.route
  		a = ", Mitfahrer: "
  		tour.confirmed_attendees.each do |attendee|
  			a << attendee.user.name+", "
  		end
  		a = a[0..-1]
  		t+a
  	end

    def twipsy_title(tour)
      tour.user.name
    end

end
