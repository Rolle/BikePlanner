class UsersController < ApplicationController
  before_filter :authenticate

  def change_group
    user = User.find(params[:user_id])
    user.update_attribute(:preferred_group, params[:group_id])
    #user.save
    redirect_to root_path
  end

  def index
    @page_id="user_index"
    @users = User.all
  end

  def show
    @page_id="user_show"
    @user = User.find(params[:id])
  end

  def new
    @page_id="user_new"
    @user = User.new
  end

  def edit
    @page_id="user_edit"
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    @user.preferred_group = current_user.preferred_group

    if @user.save
      UserMailer.delay.welcome(@user) if MailEnv::SEND_NOTIFICATION_EMAIL
      redirect_to :controller => 'tours', :action => 'index'        
    else
      render 'new'
    end
  end

  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(user_params)
        format.html { redirect_to @user, :notice => 'Benutzer wurde gespeichert.' }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
  end

  private
  def user_params
    params.require(:user).permit(:password, :mail,:phone, :name, :password_confirmation, :notification_allowed, :preferred_group)
  end  
end
