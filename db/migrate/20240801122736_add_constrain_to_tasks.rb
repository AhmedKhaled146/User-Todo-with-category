class AddConstrainToTasks < ActiveRecord::Migration[7.2]
  def change
    change_column :tasks, :title, :string, null: false
    add_index :tasks, [:category_id, :title], unique: true
  end
end
