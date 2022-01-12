class AddIndexToTasks < ActiveRecord::Migration[6.1]
  def change
    add_index :tasks, :title
    add_index :tasks, :user_id
  end
end
