class CreateUsersTours < ActiveRecord::Migration
  def up
  	drop_table :users_tours
  	create_table :tours_users, :id=>false do |t|
  	  	t.integer :user_id
  	  	t.integer :tour_id
  	end
  end

  def down
	drop_table :tours_users
  	create_table :users_tours, :id=>false do |t|
  	  	t.integer :user_id
  	  	t.integer :tour_id
  	end

  end
end
