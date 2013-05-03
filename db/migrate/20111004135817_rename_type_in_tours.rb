class RenameTypeInTours < ActiveRecord::Migration
  def up
  	remove_column :tours, :type
  	add_column :tours, :tour_type, :string
  end

  def down
  	  	remove_column :tours, :tour_type
  	add_column :tours, :type, :string

  end
end
