class TracksController < ApplicationController
  require "parser"
	def findlocation
		@page_id="track_findlocation"
	  	render "tracks"
	end

	def index
	    @page_id ="track_all"
	    @track_count = Tour.where("track_file_name is not null").count()
	    @tracks = Tour.where("track_file_name is not null")
	end

	def mtb
		@page_id ="track_mtb"
	    @track_count = Tour.where("track_file_name is not null and tour_type ='MTB'").count()
	    @tracks = Tour.where("track_file_name is not null and tour_type = 'MTB'")
	    render :index
	end

	def rr
		@page_id ="track_rennrad"
	    @track_count = Tour.where("track_file_name is not null and tour_type ='Rennrad'").count()
	    @tracks = Tour.where("track_file_name is not null and tour_type = 'Rennrad'")
	    render :index
	end
		
	def show
		@page_id = "track_show"
		@track = Tour.find(params[:id])
		@parser = Parser.create("./public"+@track.track.url)
	end
end