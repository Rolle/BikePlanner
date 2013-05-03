class TourAttendee < ActiveRecord::Base
	belongs_to :user
	belongs_to :tour
	#attr_accessible :tour_id, :user_id, :status
end
