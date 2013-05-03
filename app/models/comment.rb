class Comment < ActiveRecord::Base
	belongs_to :user
	belongs_to :tour
	#attr_accessible :comment, :tour_id
end
