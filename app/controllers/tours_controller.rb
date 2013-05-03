class ToursController < ApplicationController
  helper LaterDude::CalendarHelper
  before_filter :authenticate, :only => [:add, :cancel, :new, :edit, :create, :update, :notrated]
  include CommentsHelper
  include RatingsHelper

  respond_to :html, :js
  
  def notclosed
    @page_id = "tour_notclosed"
    @tours = Tour.find_by_sql("select * from tours where user_id=#{current_user.id} and rated is null or 
      id in (select tour_id from tour_attendees where user_id=#{current_user.id}) and rated is null and start_at < '" + DateTime.now.to_s + "'")
  end

  def close
      @tour = Tour.find(params[:id])
      @tour.update_attributes(params[:tour])
      @tour.rated = 1
      if @tour.save
        if MailEnv::SEND_NOTIFICATION_EMAIL
          @tour.users.each do |tour_user|
            if tour_user.id != current_user.id && tour_user.notification_allowed
              TourMailer.delay.close(@tour, tour_user, current_user)
            end
          end
        end
        Twitter.delay.update(current_user.name + @tour.twitter_status_close) if TwitterEnv::SEND_TWITTER_STATUS

        #format.js {render "close"}
        if @tour.track_file_name.nil?
          respond_with @tour
        else
          redirect_to track_path(@tour)
        end
      end
  end

  def month
    @page_id="tour_month"
    
    if params[:year].nil?
      @now = DateTime.now
    else
      @now = DateTime.new(params[:year].to_i, params[:month].to_i, 1)
    end
    
    from = DateTime.new(@now.year, @now.month, 1) - 6.days
    to = DateTime.new((@now + 1.month).year, (@now + 1.month).month, 1) + 6.days

    @tour = Tour.new
    @tours = Tour.where("start_at > ? AND start_at < ?", from, to)
  end

  def create
    @page_id="tour_create"
    @tour = Tour.new(tour_params)
    @tour.user_id = current_user.id
    @group = Group.find(current_user.preferred_group)
    respond_to do |format|
      if @tour.save
        if MailEnv::SEND_NOTIFICATION_EMAIL
          @group.users.each do |group_user|
            if (group_user.id != current_user.id) && group_user.notification_allowed
              TourMailer.delay.new_tour(@tour, group_user, current_user)                          
            end
          end
        end
        
        Twitter.delay.update(current_user.name + @tour.twitter_status_create) if TwitterEnv::SEND_TWITTER_STATUS
        format.html { redirect_to @tour, :notice => 'Tour wurde gespeichert.' }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def add
    @tour = Tour.find(params[:id])
    @group = Group.find(current_user.preferred_group)
    ta = TourAttendee.find_by_tour_id_and_user_id(params[:id], current_user.id)
    if ta == [] or ta.nil?
      ta = TourAttendee.create(:tour_id => params[:id], :user_id => current_user.id, :status => true)
    else
      ta.update_attributes(:status => true)
    end

    if MailEnv::SEND_NOTIFICATION_EMAIL
      @tour.users.each do |tour_user|
        if tour_user.id != current_user.id && tour_user.notification_allowed
          TourMailer.delay.add(@tour, tour_user, current_user)
        end
      end
      TourMailer.delay.add(@tour, @tour.user, current_user)
    end
    Twitter.delay.update(current_user.name + @tour.twitter_status_add) if TwitterEnv::SEND_TWITTER_STATUS
    redirect_to :action => "month"
  end

  def cancel
    @tour = Tour.find(params[:id])
    ta = TourAttendee.find_by_tour_id_and_user_id(params[:id], current_user.id)
    if ta == [] or ta.nil?
      TourAttendee.create(:tour_id => params[:id], :user_id => current_user.id, :status => false)
    else
      ta.update_attributes(:status => false)
    end

    if MailEnv::SEND_NOTIFICATION_EMAIL
      @tour.users.each do |tour_user|
        if tour_user.id != current_user.id && tour_user.notification_allowed
          TourMailer.delay.cancel(@tour, tour_user, current_user)
        end
      end
      TourMailer.delay.cancel(@tour, @tour.user, current_user)
    end
    Twitter.delay.update(current_user.name + @tour.twitter_status_cancel) if TwitterEnv::SEND_TWITTER_STATUS
    redirect_to :action => "month"
  end

  def week
    @page_id="tour_week"
    @grid = []
    @dates = timeline
    @weather = Weather.new
    @tour = Tour.new
    now = DateTime.now    

    tours = Tour.where("start_at > ? and start_at < ?", now, (now+7.days).midnight)
    tours.each do |tour|         
      day_index = (tour.start_at.to_datetime-now).to_f.round
      @grid[day_index] ||= []
      @grid[day_index] << tour              
    end
  end
  
  def own
    @page_id = "tour_own"
    @now = DateTime.now
    @new_rating = Rating.new
    @tours = Tour.find_all_by_user_id(current_user.id)
    @tour = Tour.new
    #@tours = User.find(current_user.id).tours
    render 'index'
  end
  
  def index
    @page_id = "tour_all"
    @tours = Tour.order("start_at desc").all()
    @tour = Tour.new
    @now = DateTime.now
    @new_rating = Rating.new
  end

  def show
    @page_id = "tour_show"
    @tour = Tour.find(params[:id])
  end

  def new
    @page_id = "tour_new"
    @tour = Tour.new
  end

  def edit
    @page_id = "tour_edit"
    @tour = Tour.new
    @tour_to_edit = Tour.find(params[:id])
  end



  def update
    @tour = Tour.find(params[:id])

    respond_to do |format|
      if @tour.update_attributes(params[:tour])
        format.html { redirect_to @tour, :notice => 'Tour wurde gespeichert.' }
      else
        format.html { render :action => "edit" }
        format.js 
      end
    end
  end

  def destroy
    @tour = Tour.find(params[:id])
    @tour.destroy

    respond_to do |format|
      format.html { redirect_to tours_url }
    end
  end

  private
  def tour_params
    params.require(:tour).permit(:track,:duration, :tour_type, :route, :meeting_point, :start_at, :link, :distance, :alt, :tour_id, :group_id, :user_id)
  end
end
