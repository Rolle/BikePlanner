module CommentsHelper
	def comment_if_not_exists(comment)
		if comment.nil?
			return Comment.new 
		else 
			return comment
		end
	end
end
