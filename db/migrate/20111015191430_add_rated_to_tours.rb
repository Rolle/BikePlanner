class AddRatedToTours < ActiveRecord::Migration
  def change
    add_column :tours, :rated, :integer
    add_column :tours, :distance, :integer
    add_column :tours, :comment, :string
    add_column :tours, :rating, :integer
    add_column :tours, :alt, :integer
  end
end
