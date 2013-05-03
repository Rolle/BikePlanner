class ApplicationController < ActionController::Base

	require "date_time_helper"
	include DateTimeHelper
  include SessionsHelper

	protect_from_forgery
  before_filter :page_id, :latest, :set_locale
  
  private	
  	  
  def page_id
  	@page_id="app"
  end

  def latest
    @last_comments = Comment.all(:limit => 5, :order => "created_at DESC")    
    @last_tracks = Tour.where("track_file_name is not null").limit(5).order("track_updated_at desc")
    @last_tours = Tour.find(:all, :limit => 5, :order => "start_at DESC")
    @last_internet_news = InternetNew.new
    #@weather = Weather.new
    #@last_posts = Post.find(:all, :limit => 5, :order => "created_at DESC")
    @last_calenders = Calender.where("begin_of_event > '" + DateTime.now.strftime("%Y-%m-%d %H:%M")+"'").limit(10).order("begin_of_event asc")
    #@last_calenders = Calender.find(:all, :limit => 10, :order => "begin_of_event")
    @new_comment  = Comment.new
  end

  def authenticate
    deny_access unless signed_in?
  end
 
  def set_locale

    I18n.locale = params[:locale] || I18n.default_locale
    session[:locale] = params[:locale] || I18n.locale
    puts 
  end
end
