module RatingsHelper
	def pill(rating)
		return content_tag(:span, "1", :class=>"badge badge-success") if (rating == 1 || rating == "Sehr gut")
		return content_tag(:span, "2", :class=>"badge badge-info") if (rating == 2 || rating == "Gut")
		return content_tag(:span, "3", :class=>"badge badge-default") if (rating == 3 || rating == "Befriedigend")
		return content_tag(:span, "4", :class=>"badge badge-warning") if (rating == 4 || rating == "Ausreichend")
		return content_tag(:span, "5", :class=>"badge badge-important") if (rating == 5 || rating == "Mangelhaft")
	end

	def speed_rating(rating)
		return "Genau richtig" if rating == 1
		return "Bisschen schneller bitte!" if rating == 2
		return "Sind doch keine Rennfahrer!" if rating ==3
	end

	def route_rating(rating)
		return "Top!" if rating == 1
		return "Zu flach" if rating  == 2
		return "Zu oft gefahren" if rating == 3
		return "Zu bergig" if rating == 4
		return "Laaaangweilig"  if rating == 5
	end


	def average(ratings)
		return 0 if ratings.size == 0
		sum = 0
		ratings.each do |rating| 
			sum += rating.rating  if !rating.nil?
		end
		avg = (sum.to_f/ ratings.size).round(2)
		avg
	end

	def rating_if_not_exists(rating)
		if rating.nil?
			return Rating.new 
		else 
			return rating
		end
	end
end
