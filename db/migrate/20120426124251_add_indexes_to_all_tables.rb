class AddIndexesToAllTables < ActiveRecord::Migration
  def change

  	change_table :users do |t|
  		t.index :id
  		t.index :preferred_group
  		t.index :mail
  	end

  	change_table :tours_users do |t|
  		t.index :user_id
  		t.index :tour_id
  	end

  	change_table :tours do |t|
  		t.index :id
  		t.index :user_id
  		t.index :group_id
  	end

  	change_table :tour_attendees do |t|
  		t.index :tour_id
  		t.index :user_id
  	end

  	change_table :ratings do |t|
  		t.index :id
  		t.index :tour_id
  		t.index :user_id
  	end

  	change_table :posts do |t|
  		t.index :id
  		t.index :user_id
  	end

  	change_table :news do |t|
  		t.index :id
  		t.index :user_id
  	end

  	change_table :groups_users do |t|
  		t.index :group_id
  		t.index :user_id
  	end

  	change_table :groups do |t|
  		t.index :id
  	end

  	change_table :comments do |t|
  		t.index :id
  		t.index :user_id
  		t.index :tour_id
  	end

  	change_table :calenders do |t|
  		t.index :id
  		t.index :group_id
  		t.index :user_id
  	end

  end
end
