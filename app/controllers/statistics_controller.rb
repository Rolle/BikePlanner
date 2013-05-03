class StatisticsController < ApplicationController
	  def user
	  	@page_id = "statistic_user"
	  	@group = Group.find(current_user.preferred_group)
	  end

	def tour
		@page_id = "statistic_tour"		
		@tours = Tour.find_all_by_group_id(current_user.preferred_group)
	end

	def diary
		@page_id = "statistic_diary"
		
		@group = Group.find(current_user.preferred_group)
	end
end
