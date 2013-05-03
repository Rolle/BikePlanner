class Group < ActiveRecord::Base
	#attr_accessible :url, :name

	has_and_belongs_to_many :users
	has_many :tours
end
