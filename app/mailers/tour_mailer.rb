class TourMailer < ActionMailer::Base
  default from: "bikeplanner@rolandschmitt.info"

  def add(tour, user, current_user)
    @tour = tour
    @current_user = current_user
		mail(:to => user.mail, :subject => "Anmeldung zur Tour")
  end

  def cancel(tour, user, current_user)
    @tour = tour
    @current_user = current_user
    mail(:to => user.mail, :subject => "Abmeldung von Tour")
  end

  def close(tour, user, current_user)
    @tour = tour
    @current_user = current_user
    mail(:to => user.mail, :subject => "Tour wurde abgeschlossen")
  end

  def new_tour(tour, user, current_user)
    @tour = tour
    @current_user = current_user
    mail(:to => user.mail, :subject => "Neue Tour erstellt")  
  end
end
