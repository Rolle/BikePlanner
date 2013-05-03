# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.

group_fell = Group.create(:name=>"Cycling Mosel Trier", :url =>"www.cycling-mosel-trier.de")
group_bekond = Group.create(:name=>"Bekond Aktiv", :url =>"bekond.wordpress.com")

joos = User.create(:name => "Joos",  :phone=>"01711234567", :mail => "joos@joos.de", :password => "123456", :preferred_group => group_fell.id)
rolle = User.create(:name => "Rolle",  :phone=>"01711234567", :mail => "rolle@rolle.de", :password => "123456", :preferred_group => group_fell.id)
paddi = User.create(:name => "Paddi",  :phone=>"01711234567", :mail => "paddi@paddi.de", :password => "123456", :preferred_group => group_fell.id)
kaedde = User.create(:name => "Karin",  :phone=>"01711234567", :mail => "kaedde@kaedde.de", :password => "123456", :preferred_group => group_fell.id)

rolle.update_attribute(:preferred_group, 1)
joos.update_attribute(:preferred_group, 1)
kaedde.update_attribute(:preferred_group, 1)
paddi.update_attribute(:preferred_group, 1)

joos.groups << group_fell
rolle.groups << group_fell
paddi.groups << group_fell
kaedde.groups << group_fell

rolle.groups << group_bekond

Tour.create(:user_id => joos.id, :duration => 120, :tour_type => "MTB", :start_at => "2011-10-08 18:00", :route =>"Fuchsgraben", :meeting_point => "Sparkasse Fell", :group_id => 1)
Tour.create(:user_id => joos.id, :duration => 180, :tour_type => "Road", :start_at => "2011-10-09 10:30", :route =>"Wittlich", :meeting_point => "Sparkasse Fell", :group_id => 1)
Tour.create(:user_id => paddi.id, :duration => 270, :tour_type => "Road", :start_at => "2011-10-07 14:00", :route =>"Ehrang", :meeting_point => "Fastrau", :group_id => 1)
Tour.create(:user_id => paddi.id, :duration => 120, :tour_type => "Road", :start_at => "2011-10-09 16:00", :route =>"Muellerthal", :meeting_point => "Fastrau", :group_id => 1)

TourAttendee.create(:user_id => 2, :tour_id=>1)
TourAttendee.create(:user_id => 3, :tour_id=>1)
TourAttendee.create(:user_id => 4, :tour_id=>1)


TourAttendee.create(:user_id => 2, :tour_id=>2)
TourAttendee.create(:user_id => 4, :tour_id=>2)

TourAttendee.create(:user_id => 1, :tour_id=>3)
TourAttendee.create(:user_id => 2, :tour_id=>3)
TourAttendee.create(:user_id => 4, :tour_id=>3)