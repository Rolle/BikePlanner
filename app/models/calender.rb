class Calender < ActiveRecord::Base
	before_save :ensure_http_link

	belongs_to :group
	belongs_to :user
	#attr_accessible :title, :begin_of_event, :end_of_event, :place, :comment, :link
	def ensure_http_link		
		self.link = "http://" + self.link if !self.link.nil? and !self.link.start_with?("http://")
	end
end
