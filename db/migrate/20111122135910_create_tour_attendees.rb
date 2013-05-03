class CreateTourAttendees < ActiveRecord::Migration
  def change
    create_table :tour_attendees do |t|
      t.integer :tour_id
      t.integer :user_id
      t.boolean :status

      t.timestamps
    end
  end
end
