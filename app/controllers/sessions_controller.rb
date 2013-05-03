class SessionsController < ApplicationController
  def new
    @page_id="session_login"
  end
  
  def create
    user = User.authenticate(params[:session][:mail], params[:session][:password])
    if user.nil?
      flash.now[:error] = "Invalid email or password."
      @title = "Sign in"
    else
      user.update_column(:last_login, DateTime.now)
      sign_in user
    end
    redirect_to root_path
  end
  
  def destroy
    sign_out
    redirect_to root_path
  end

  def changelog
    @page_id = "sessions_changelog"
  end

  def imprint
    @page_id = "sessions_imprint"
  end

  
  private
  
  def page_id
  	  @page_id = "sessions"
  end

end