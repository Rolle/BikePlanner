class RemoveGpsiesidFromTours < ActiveRecord::Migration
  def up
  	remove_column :tours, :gpsiesid
  	add_column :tours, :gpsiesid, :string
  end

  def down
  	remove_column :tours, :gpsiesid
  	add_column :tours, :gpsiesid, :int
  end
end
