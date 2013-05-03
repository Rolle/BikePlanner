class RatingsController < ApplicationController
  before_filter :authenticate, :only => [:create, :new, :update, :destroy]
  
  respond_to :html, :js

  def create
    @rating = Rating.new(rating_params)
    @rating.user_id = current_user.id
    @rating.save!
    @tour = Tour.find(@rating.tour_id)
    @new_rating = Rating.new
  end

  def new
  end

  def update
  end

  def destroy
  end

  def show
    @tour = Tour.find(params[:id])
  	#@ratings = Rating.where('tour_id = ?', params[:id])
    respond_with @ratings#, :location => ratings_url
  end

  private
  def rating_params
    params.require(:rating).permit(:rating, :comment)
  end
end
