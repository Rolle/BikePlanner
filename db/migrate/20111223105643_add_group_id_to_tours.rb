class AddGroupIdToTours < ActiveRecord::Migration
  def change
    add_column :tours, :group_id, :integer
  end
end
