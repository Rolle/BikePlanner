class AddTrackToTours < ActiveRecord::Migration
  def self.up
  	add_attachment :tours, :track
  end

  def self.down
  	remove_attachment :tours, :track
  end
end
