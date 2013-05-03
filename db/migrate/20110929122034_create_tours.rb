class CreateTours < ActiveRecord::Migration
  def change
    create_table :tours do |t|
      t.integer :user_id
      t.integer :duration
      t.string :type
      t.datetime :start_at
      t.string :route
      t.string :meeting_point

      t.timestamps
    end
  end
end
