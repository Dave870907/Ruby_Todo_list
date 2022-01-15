class CreateLabelRelations < ActiveRecord::Migration[6.1]
  def change
    create_table :label_relations do |t|
      t.references :task
      t.references :label

      t.timestamps
    end
  end
end
