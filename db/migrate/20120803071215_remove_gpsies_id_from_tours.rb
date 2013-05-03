class RemoveGpsiesIdFromTours < ActiveRecord::Migration
  def up
  	remove_column :tours, :gpsiesid
  end

  def down
  	add_column :tours, :gpsiesid, :int
  end
end
