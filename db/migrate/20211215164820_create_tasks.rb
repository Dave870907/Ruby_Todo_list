class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.integer :status
      t.string :title
      t.text :content
      t.integer :order
      t.string :category
      t.integer :user_id

      t.timestamps
    end
  end
end
