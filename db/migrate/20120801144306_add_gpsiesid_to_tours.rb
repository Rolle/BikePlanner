class AddGpsiesidToTours < ActiveRecord::Migration
  def change
    add_column :tours, :gpsiesid, :int
  end
end
