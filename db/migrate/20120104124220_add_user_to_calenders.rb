class AddUserToCalenders < ActiveRecord::Migration
  def change
    add_column :calenders, :user_id, :integer
  end
end
