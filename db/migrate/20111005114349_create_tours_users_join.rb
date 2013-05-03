class CreateToursUsersJoin < ActiveRecord::Migration
  def up
  	  create_table :users_tours, :id=>false do |t|
  	  	t.integer :user_id
  	  	t.integer :tour_id
  	  end
  end

  def down
	drop_table :users_tours
  end
end
