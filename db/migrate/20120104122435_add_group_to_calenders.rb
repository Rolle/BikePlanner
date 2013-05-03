class AddGroupToCalenders < ActiveRecord::Migration
  def change
    add_column :calenders, :group_id, :integer
  end
end
