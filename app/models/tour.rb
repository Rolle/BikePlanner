class Tour < ActiveRecord::Base
	belongs_to :user
	belongs_to :group
	has_many :tour_attendees
	has_many :ratings
	has_many :comments
	has_many :users, :through => :tour_attendees
	
	before_save :ensure_http_link

	validates :duration, :presence => true, :numericality => { :only_integer => true }
   	validates :start_at, :presence => true
   	validates :tour_type, :presence => true
   	validates :route, :presence => true, :length => { :minimum => 4 }
   	validates :meeting_point, :presence => true

   	#attr_accessible :track,:duration, :tour_type, :route, :meeting_point, :start_at, :link, :distance, :alt, :tour_id, :group_id, :user_id
   	has_attached_file :track

   	def start_time
   		start_at
   	end
   	
   	def index
   		unless (self.alt.nil? or self.distance.nil? or self.duration.nil?)
   			base = (0.1*(self.alt*self.alt)/self.distance+40*self.alt/self.distance+self.distance/10000+self.duration/1000)
   			base = base - (base * 0.05 * self.users.size()) #(c=Höhenmeter,d=distance in m,T top of mountain in m)
   			return base
   		else
   			return 0
   		end
   	end

   	def twitter_status_create
   		return " hat eine neue Tour angelegt. Start: " + self.start_at.strftime("%d.%m.%y, %H:%M") + " Uhr, Treffpunkt: " + self.meeting_point + " mit dem " + self.tour_type + 
   		". Geplant sind " + self.duration.to_s + " Minuten."
   	end

   	def twitter_status_add
   		return " hat sich zur Tour am " + self.start_at.strftime("%d.%m.%y, %H:%M") + " Uhr angemeldet."
   	end

   	def twitter_status_cancel
   		return " hat sich von der Tour am " + self.start_at.strftime("%d.%m.%y, %H:%M") + " Uhr abgemeldet."
   	end

   	def twitter_status_close
   		return " hat die Tour am " + self.start_at.strftime("%d.%m.%y, %H:%M") + " Uhr abgeschlossen. Die Daten sind "
   		 + self.distance.to_s + " km, " + self.alt.to_s + " Hoehenmeter und " + self.duration.to_s + " Minuten Fahrzeit."
   	end

   	def rated?
   		self.rated == 1
   	end
   	
	def ensure_http_link
		if !self.link.nil? and !self.link.start_with?("http://")
			self.link = "http://" + self.link
		end
	end

	def get_users_list
		list = ""
		
		if users
			users.each do |user|
				if list == ""
					list = user.name
				else
					list = list + ", " + user.name
				end
			end
		end
		list
	end

	def users_to_a
		u=[]
		users.map{|user| u << user.name}
	end
	
	def confirmed?(user)
		#true if TourAttendee.find_all_by_tour_id_and_user_id_and_status(self.id, user.id, true) != []
		true if TourAttendee.find(:first, :conditions => ["tour_id = ? and user_id = ? and status = ?", self.id, user.id, true])
	end

	def unconfirmed?(user)
		#true if TourAttendee.find_all_by_tour_id_and_user_id_and_status(self.id, user.id, false) != []
		true if TourAttendee.find(:first, :conditions => ["tour_id = ? and user_id = ? and status = ?", self.id, user.id, false])
	end

	def rated_by?(user)
		true if Rating.find(:first, :conditions => [ "user_id = ? and tour_id = ?", user.id, self.id])
	end

	def confirmed_attendees
		TourAttendee.find_all_by_tour_id_and_status(self.id, true)
	end

	def unconfirmed_attendees
		TourAttendee.find_all_by_tour_id_and_status(self.id, false)
	end
end
