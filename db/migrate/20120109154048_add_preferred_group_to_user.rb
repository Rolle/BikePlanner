class AddPreferredGroupToUser < ActiveRecord::Migration
  def change
    add_column :users, :preferred_group, :integer

  end
end
