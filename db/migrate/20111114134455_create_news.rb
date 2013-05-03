class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.integer :user_id
      t.string :link
      t.string :text

      t.timestamps
    end
  end
end
