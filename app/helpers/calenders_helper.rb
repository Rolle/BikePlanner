module CalendersHelper
  	def event_on_day(events, day)  		
  		events.each do |event|
  			if (event.begin_of_event.day == day.day && event.begin_of_event.month == day.month && event.begin_of_event.year == day.year)
  				return event
  			end
  		end
  		false
  	end
  	
  	def twipsy_event(event)
  		event.title + " in " + event.place 
  	end
end
