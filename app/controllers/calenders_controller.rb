class CalendersController < ApplicationController
  helper LaterDude::CalendarHelper
  before_filter :authenticate, :only => [:create, :new, :update, :destroy]

  def index
    @page_id = "calender_index"
    @calender = Calender.new
    @calenders = Calender.all(:order => "begin_of_event")#.where("begin_of_event < ?", DateTime.now)
  end

  def month
    @page_id="calender_month"
    @calender = Calender.new
    
    if params[:year].nil?
      @now = DateTime.now
    else
      @now = DateTime.new(params[:year].to_i, params[:month].to_i, 1)
    end
    
    @now_ = @now + 1.month
    from = DateTime.new(@now.year, @now.month, 1)
    to = DateTime.new(@now_.year, @now_.month, 1)
    @events = Calender.where("begin_of_event > ? AND begin_of_event < ?", from, to)
  end

  def show
    @page_id = "calender_show"
    @calender = Calender.find(params[:id])
  end

  def new
    @page_id = "calender_new"
    @new_calender = Calender.new
  end

  def edit
    @page_id = "calender_edit"
    @calender = Calender.find(params[:id])
  end

  def create
    @calender = Calender.new(calender_params)
    @calender.user_id = current_user.id
    @new_calender = Calender.new
    if @calender.save
      redirect_to @calender, :notice => 'Neuer Kalendereintrag wurde gespeichert.' 
    else
      render :action => "new"
    end
  end

  def update
    @calender = Calender.find(params[:id])

    if @calender.update_attributes(params[:calender])
      redirect_to @calender, :notice =>  'Kalendereintrag wurde gespeichert.'
    else
      render :action => "edit"
    end
  end

  def destroy
    @calender = Calender.find(params[:id])
    @calender.destroy

    redirect_to calenders_url
  end

  private
  def calender_params
    params.require(:calender).permit(:title, :begin_of_event, :end_of_event, :place, :comment, :link)
  end
end
