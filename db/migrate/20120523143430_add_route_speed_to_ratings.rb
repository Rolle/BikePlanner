class AddRouteSpeedToRatings < ActiveRecord::Migration
  def change
    add_column :ratings, :route, :integer
    add_column :ratings, :speed, :integer
  end
end
