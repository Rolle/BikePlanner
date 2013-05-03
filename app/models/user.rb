class User < ActiveRecord::Base
   has_and_belongs_to_many :groups#, :through => :groups_users
   has_many :ratings, :dependent => :destroy
   has_many :tour_attendees
   has_many :tours#, :through => :tour_attendees, :dependent => :destroy
   has_many :posts
   has_many :tracks   
   has_many :calenders
   #has_many :groups
   has_and_belongs_to_many :groups
   
   before_save :encrypt_password
   
   attr_accessor :password
   
   mail_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
      
   validates   :mail, :presence => true, 
               :format   => { :with => mail_regex },
               :uniqueness => { :case_sensitive => false }
   
   validates :password, :presence     => true,
                       :confirmation => true,
                       :length       => { :within => 6..40 }
                       

   
   #attr_accessible :password, :mail,:phone, :name, :password_confirmation, :notification_allowed, :preferred_group
   
   def is_admin?
      self.is_admin
   end
   #----------------- Scores -----------------#
   #------------------------------------------#
   def score_tours(group_id)
      self.tours.size
   end
   def score_own_attendees(group_id)
      self.tour_attendees.size
   end
   def score_ratings(group_id)
      self.ratings.size
   end
   def score_posts(group_id)
      self.posts.size
   end
   def score_calenders(group_id)
      self.calenders.size
   end
   def score_tour_attendees(group_id)
      tours = Tour.arel_table
      TourAttendee.where(:tour_id =>tours.project(:id).where(tours[:user_id].eq(self.id)).where(tours[:group_id].eq(group_id))).size
   end
   def score_overall(group_id)
      return (
         score_tours(group_id) * 6 +          
         score_tour_attendees(group_id) * 5 +
         score_own_attendees(group_id) * 4 + 
         score_calenders(group_id) * 3 + 
         score_posts(group_id) * 2 + 
         score_ratings(group_id) )
   end

   def group_names      
      self.groups.map{|group| group.name}
   end
   
   def sum_alt
      sum_alt = 0
      self.tour_attendees.each do |ta|
         sum_alt = sum_alt + ta.tour.alt if !ta.tour.nil? && !ta.tour.alt.nil?
      end
      sum_alt
   end

   def sum_duration
      sum_duration = 0
      self.tour_attendees.each do |ta|
         sum_duration = sum_duration + ta.tour.duration if !ta.tour.nil? && !ta.tour.duration.nil?
      end
      sum_duration
   end

   def sum_distance
      sum_distance = 0

      self.tour_attendees.each do |ta|
         sum_distance = sum_distance + ta.tour.distance if !ta.tour.nil? && !ta.tour.distance.nil?
      end
      sum_distance
   end

   def has_password?(submitted_password)
      encrypted_password == encrypt(submitted_password)
   end

   def self.authenticate(mail, submitted_password)
	   user = find_by_mail(mail)
	   return nil if user.nil?
	   return user if user.has_password?(submitted_password)
   end
   	 
  def self.authenticate_with_salt(id, cookie_salt)
     user = find_by_id(id)
     return nil  if user.nil?
     return user if user.salt == cookie_salt
  end
  
   
   private
   def encrypt_password
	   self.salt = make_salt if new_record?
      self.encrypted_password = encrypt(password)
   end

   def encrypt(string)
	   secure_hash("#{salt}--#{string}")
   end

   def make_salt
	   secure_hash("#{Time.now.utc}--#{password}")
   end

   def secure_hash(string)
	   Digest::SHA2.hexdigest(string)
   end
end
