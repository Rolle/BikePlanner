class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :tour_id
      t.integer :user_id
      t.integer :rating
      t.string :comment

      t.timestamps
    end
  end
end
