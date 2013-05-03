class UserMailer < ActionMailer::Base
  default from: "bikeplanner@rolandschmitt.info"

  def welcome(user)
  	@user = user
  	mail(:to => @user.mail, :subject => "Willkommen zum BikePlanner!")
  end

end
