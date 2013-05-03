class CreateCalenders < ActiveRecord::Migration
  def change
    create_table :calenders do |t|
      t.datetime :begin_of_event
      t.datetime :end_of_event
      t.string :place
      t.string :title
      t.string :comment
      t.string :link

      t.timestamps
    end
  end
end
